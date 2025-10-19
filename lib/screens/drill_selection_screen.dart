import 'package:flutter/material.dart';
import '../models/drill.dart';
import '../data/takedown_drills.dart';
import 'timer_configuration_screen.dart';

class DrillSelectionScreen extends StatefulWidget {
  const DrillSelectionScreen({super.key});

  @override
  State<DrillSelectionScreen> createState() => _DrillSelectionScreenState();
}

class _DrillSelectionScreenState extends State<DrillSelectionScreen> {
  final Set<String> _selectedDrillIds = <String>{};
  String _selectedDifficulty = 'All';

  final List<String> _difficultyLevels = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    List<Drill> filteredDrills = _selectedDifficulty == 'All'
        ? TakedownDrills.drills
        : TakedownDrills.getDrillsByDifficulty(_selectedDifficulty);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Drills for Fast Training',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          if (_selectedDrillIds.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedDrillIds.clear();
                });
              },
              child: const Text('Clear All'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Header with selection info
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Row(
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
                        '${_selectedDrillIds.length} drills selected',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedDrillIds.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${_selectedDrillIds.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Difficulty filter
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Difficulty:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _difficultyLevels.map((difficulty) {
                      final isSelected = _selectedDifficulty == difficulty;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(difficulty),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = difficulty;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primaryContainer,
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Drills list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredDrills.length,
              itemBuilder: (context, index) {
                final drill = filteredDrills[index];
                final isSelected = _selectedDrillIds.contains(drill.id);
                return _DrillSelectionCard(
                  drill: drill,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedDrillIds.remove(drill.id);
                      } else {
                        _selectedDrillIds.add(drill.id);
                      }
                    });
                  },
                );
              },
            ),
          ),

          // Continue button
          if (_selectedDrillIds.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final selectedDrills = TakedownDrills.drills
                        .where((drill) => _selectedDrillIds.contains(drill.id))
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerConfigurationScreen(
                          selectedDrills: selectedDrills,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.timer),
                  label: const Text('Continue to Timer Setup'),
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
}

class _DrillSelectionCard extends StatelessWidget {
  final Drill drill;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrillSelectionCard({
    required this.drill,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color difficultyColor;
    IconData difficultyIcon;
    
    switch (drill.difficulty) {
      case 'Beginner':
        difficultyColor = Colors.green;
        difficultyIcon = Icons.star;
        break;
      case 'Intermediate':
        difficultyColor = Colors.orange;
        difficultyIcon = Icons.star_half;
        break;
      case 'Advanced':
        difficultyColor = Colors.red;
        difficultyIcon = Icons.star_border;
        break;
      default:
        difficultyColor = Colors.grey;
        difficultyIcon = Icons.star;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected 
              ? Theme.of(context).colorScheme.primary 
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Selection checkbox
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary 
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary 
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
              
              const SizedBox(width: 12),
              
              // Drill info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            drill.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: difficultyColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: difficultyColor.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                difficultyIcon,
                                size: 14,
                                color: difficultyColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                drill.difficulty,
                                style: TextStyle(
                                  color: difficultyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drill.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${drill.estimatedTime} min',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
