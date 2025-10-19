import 'package:flutter/material.dart';
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
  int _intervalMinutes = 2;
  int _intervalSeconds = 0;
  bool _randomOrder = true;
  bool _repeatDrills = true;

  final List<int> _minuteOptions = [0, 1, 2, 3, 5, 10, 15, 20, 30];
  final List<int> _secondOptions = [0,1 , 2, 5, 10, 15, 30, 45];

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
                    child: Column(
                      children: [
                        // Minutes selection
                        Text(
                          'Minutes:',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: _minuteOptions.map((minutes) {
                            final isSelected = _intervalMinutes == minutes;
                            return FilterChip(
                              label: Text('$minutes'),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _intervalMinutes = minutes;
                                });
                              },
                              selectedColor: Theme.of(context).colorScheme.primaryContainer,
                              checkmarkColor: Theme.of(context).colorScheme.primary,
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Seconds selection
                        Text(
                          'Seconds:',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: _secondOptions.map((seconds) {
                            final isSelected = _intervalSeconds == seconds;
                            return FilterChip(
                              label: Text('$seconds'),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _intervalSeconds = seconds;
                                });
                              },
                              selectedColor: Theme.of(context).colorScheme.primaryContainer,
                              checkmarkColor: Theme.of(context).colorScheme.primary,
                            );
                          }).toList(),
                        ),
                      ],
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
