import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/drill.dart';
import 'fast_training_screen.dart';

class TimerConfigurationScreen extends StatefulWidget {
  final List<Drill> selectedDrills;

  const TimerConfigurationScreen({
    super.key,
    required this.selectedDrills,
  });

  @override
  State<TimerConfigurationScreen> createState() => _TimerConfigurationScreenState();
}

class _TimerConfigurationScreenState extends State<TimerConfigurationScreen> {
  int _intervalMinutes = 0;
  int _intervalSeconds = 5;
  bool _randomOrder = true;
  bool _repeatDrills = true;


  @override
  Widget build(BuildContext context) {
    final totalTime = _intervalMinutes * 60 + _intervalSeconds;
    final totalDrills = widget.selectedDrills.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timer Configuration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Header info
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.sports_martial_arts,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fast Training Setup',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            '$totalDrills drills selected',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InfoItem(
                        icon: Icons.timer,
                        label: 'Interval',
                        value: '${_intervalMinutes}m ${_intervalSeconds}s',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _InfoItem(
                        icon: Icons.repeat,
                        label: 'Total Time',
                        value: _calculateTotalTime(),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time interval selection
                  _SectionCard(
                    title: 'Time Interval',
                    subtitle: 'How long between each drill announcement',
                    child: _iPhoneTimePicker(
                      minutes: _intervalMinutes,
                      seconds: _intervalSeconds,
                      onMinutesChanged: (minutes) {
                        setState(() {
                          _intervalMinutes = minutes;
                        });
                      },
                      onSecondsChanged: (seconds) {
                        setState(() {
                          _intervalSeconds = seconds;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Training options
                  _SectionCard(
                    title: 'Training Options',
                    subtitle: 'Customize your training experience',
                    child: Column(
                      children: [
                        _OptionSwitch(
                          title: 'Random Order',
                          subtitle: 'Announce drills in random order',
                          value: _randomOrder,
                          onChanged: (value) {
                            setState(() {
                              _randomOrder = value;
                            });
                          },
                          icon: Icons.shuffle,
                        ),
                        const Divider(),
                        _OptionSwitch(
                          title: 'Repeat Drills',
                          subtitle: 'Allow drills to be repeated during training',
                          value: _repeatDrills,
                          onChanged: (value) {
                            setState(() {
                              _repeatDrills = value;
                            });
                          },
                          icon: Icons.repeat,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Selected drills preview
                  _SectionCard(
                    title: 'Selected Drills',
                    subtitle: 'Drills that will be announced during training',
                    child: Column(
                      children: widget.selectedDrills.take(5).map((drill) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sports_martial_arts,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  drill.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(drill.difficulty).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  drill.difficulty,
                                  style: TextStyle(
                                    color: _getDifficultyColor(drill.difficulty),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  if (widget.selectedDrills.length > 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '... and ${widget.selectedDrills.length - 5} more drills',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Start training button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FastTrainingScreen(
                        selectedDrills: widget.selectedDrills,
                        intervalSeconds: totalTime,
                        randomOrder: _randomOrder,
                        repeatDrills: _repeatDrills,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Fast Training'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalTime() {
    if (widget.selectedDrills.isEmpty) return '0 min';
    
    final totalDrills = _repeatDrills ? 10 : widget.selectedDrills.length; // Assume 10 drills for repeat mode
    final totalSeconds = totalDrills * (_intervalMinutes * 60 + _intervalSeconds);
    final totalMinutes = (totalSeconds / 60).round();
    
    if (totalMinutes < 60) {
      return '$totalMinutes min';
    } else {
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _iPhoneTimePicker extends StatefulWidget {
  final int minutes;
  final int seconds;
  final ValueChanged<int> onMinutesChanged;
  final ValueChanged<int> onSecondsChanged;

  const _iPhoneTimePicker({
    required this.minutes,
    required this.seconds,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
  });

  @override
  State<_iPhoneTimePicker> createState() => _iPhoneTimePickerState();
}

class _iPhoneTimePickerState extends State<_iPhoneTimePicker> {
  late FixedExtentScrollController _minutesController;
  late FixedExtentScrollController _secondsController;

  final List<int> _minutesList = List.generate(31, (index) => index); // 0-30 minutes
  final List<int> _secondsList = List.generate(60, (index) => index); // 0-59 seconds

  @override
  void initState() {
    super.initState();
    _minutesController = FixedExtentScrollController(initialItem: widget.minutes);
    _secondsController = FixedExtentScrollController(initialItem: widget.seconds);
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // Minutes picker
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'MIN',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Selection indicator
                      Center(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),
                      // ListWheelScrollView
                      ListWheelScrollView.useDelegate(
                        controller: _minutesController,
                        itemExtent: 40,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          widget.onMinutesChanged(_minutesList[index]);
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            if (index >= _minutesList.length) return null;
                            final value = _minutesList[index];
                            final isSelected = value == widget.minutes;
                            
                            return Center(
                              child: Text(
                                value.toString().padLeft(2, '0'),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: isSelected 
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            );
                          },
                          childCount: _minutesList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Separator
          Container(
            width: 1,
            height: 120,
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          
          // Seconds picker
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'SEC',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Selection indicator
                      Center(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),
                      // ListWheelScrollView
                      ListWheelScrollView.useDelegate(
                        controller: _secondsController,
                        itemExtent: 40,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          widget.onSecondsChanged(_secondsList[index]);
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            if (index >= _secondsList.length) return null;
                            final value = _secondsList[index];
                            final isSelected = value == widget.seconds;
                            
                            return Center(
                              child: Text(
                                value.toString().padLeft(2, '0'),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: isSelected 
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            );
                          },
                          childCount: _secondsList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _OptionSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  const _OptionSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
