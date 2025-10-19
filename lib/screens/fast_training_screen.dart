import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/drill.dart';
import '../services/tts_service.dart';

class FastTrainingScreen extends StatefulWidget {
  final List<Drill> selectedDrills;
  final int intervalSeconds;
  final bool randomOrder;
  final bool repeatDrills;

  const FastTrainingScreen({
    super.key,
    required this.selectedDrills,
    required this.intervalSeconds,
    required this.randomOrder,
    required this.repeatDrills,
  });

  @override
  State<FastTrainingScreen> createState() => _FastTrainingScreenState();
}

class _FastTrainingScreenState extends State<FastTrainingScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  bool _isRunning = false;
  int _currentDrillIndex = 0;
  int _timeRemaining = 0;
  Drill? _currentDrill;
  List<Drill> _drillQueue = [];
  int _totalDrillsAnnounced = 0;
  int _currentRound = 1;
  
  // Animation controllers for visual feedback
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  
  // TTS service
  final TTSService _ttsService = TTSService();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupDrillQueue();
    _timeRemaining = widget.intervalSeconds;
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    await _ttsService.initialize();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Initialize slide controller to show the card immediately
    _slideController.value = 1.0;
  }

  void _setupDrillQueue() {
    _drillQueue = List.from(widget.selectedDrills);
    if (widget.randomOrder) {
      _drillQueue.shuffle(Random());
    }
  }

  void _startTraining() {
    setState(() {
      _isRunning = true;
    });
    _announceNextDrill();
    _startTimer();
  }

  void _stopTraining() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    _pulseController.stop();
    _slideController.stop();
  }

  void _pauseTraining() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    _pulseController.stop();
  }

  void _resumeTraining() {
    setState(() {
      _isRunning = true;
    });
    _startTimer();
    _pulseController.repeat(reverse: true);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
      });

      if (_timeRemaining <= 0) {
        _announceNextDrill();
        _timeRemaining = widget.intervalSeconds;
      }
    });
  }

  void _announceNextDrill() {
    if (_drillQueue.isEmpty) {
      if (widget.repeatDrills) {
        _setupDrillQueue();
        _currentRound++;
      } else {
        _stopTraining();
        _showTrainingCompleteDialog();
        return;
      }
    }

    _currentDrill = _drillQueue.removeAt(0);
    _totalDrillsAnnounced++;
    
    // Announce drill name using TTS
    if (_currentDrill != null) {
      _ttsService.speak(_currentDrill!.name);
    }
    
    setState(() {
      _currentDrillIndex = (_currentDrillIndex + 1) % widget.selectedDrills.length;
    });

    // Trigger animations for visual feedback
    _slideController.reset(); // Reset to beginning position
    _slideController.forward().then((_) {
      // Keep the card visible at the final position
      _slideController.value = 1.0;
    });
    
    // Start pulse animation and keep it running
    _pulseController.repeat(reverse: true);
  }

  void _showTrainingCompleteDialog() {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.trainingComplete),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(l10n.completedDrills(_totalDrillsAnnounced)),
            if (widget.repeatDrills && _currentRound > 1)
              Text(l10n.completedRounds(_currentRound)),
            const SizedBox(height: 8),
            Text(
              l10n.greatJob,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(l10n.finish),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildDrillCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            _currentDrill != null ? Icons.sports_martial_arts : Icons.play_circle_outline,
            size: 48,
            color: _currentDrill != null 
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            _currentDrill?.name ?? l10n.readyToStartTraining,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _currentDrill != null 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _currentDrill?.description ?? l10n.tapStartToBegin,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_currentDrill != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getDifficultyColor(_currentDrill!.difficulty).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getDifficultyColor(_currentDrill!.difficulty).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                _currentDrill!.difficulty,
                style: TextStyle(
                  color: _getDifficultyColor(_currentDrill!.difficulty),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                l10n.drillsSelected(widget.selectedDrills.length),
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _slideController.dispose();
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.fastTraining,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _stopTraining();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Training status header
          Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatCard(
                      icon: Icons.sports_martial_arts,
                      label: l10n.drillsDone,
                      value: '$_totalDrillsAnnounced',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    _StatCard(
                      icon: Icons.timer,
                      label: l10n.nextIn,
                      value: _formatTime(_timeRemaining),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    _StatCard(
                      icon: Icons.list,
                      label: l10n.remaining,
                      value: '${_drillQueue.length}',
                      color: Colors.orange,
                    ),
                  ],
                ),
                if (widget.repeatDrills && _currentRound > 1) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      l10n.round(_currentRound),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Main training area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Current drill display with animations
                  _currentDrill != null 
                    ? SlideTransition(
                        position: _slideAnimation,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: _buildDrillCard(context),
                        ),
                      )
                    : _buildDrillCard(context),

                  const SizedBox(height: 32),

                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Start/Stop/Pause button
                      ElevatedButton.icon(
                        onPressed: _isRunning ? _pauseTraining : (_timeRemaining < widget.intervalSeconds ? _resumeTraining : _startTraining),
                        icon: Icon(_isRunning ? Icons.pause : (_timeRemaining < widget.intervalSeconds ? Icons.play_arrow : Icons.play_arrow)),
                        label: Text(_isRunning ? l10n.pause : (_timeRemaining < widget.intervalSeconds ? l10n.resume : l10n.start)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          backgroundColor: _isRunning ? Colors.orange : Colors.green,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Stop button
                      ElevatedButton.icon(
                        onPressed: _stopTraining,
                        icon: const Icon(Icons.stop),
                        label: Text(l10n.stop),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Progress indicator
                  if (_isRunning) ...[
                    Text(
                      l10n.trainingInProgress,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _timeRemaining / widget.intervalSeconds,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ] else if (_timeRemaining < widget.intervalSeconds) ...[
                    Text(
                      l10n.trainingPaused,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.orange[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _timeRemaining / widget.intervalSeconds,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.orange,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Training info footer
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoItem(
                  icon: Icons.settings,
                  label: l10n.interval,
                  value: _formatTime(widget.intervalSeconds),
                ),
                _InfoItem(
                  icon: Icons.shuffle,
                  label: l10n.order,
                  value: widget.randomOrder ? l10n.random : l10n.sequential,
                ),
                _InfoItem(
                  icon: Icons.repeat,
                  label: l10n.repeat,
                  value: widget.repeatDrills ? l10n.yes : l10n.no,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    // Note: This method should ideally receive localized difficulty strings
    // For now, we'll check against both English and Portuguese
    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'iniciante':
        return Colors.green;
      case 'intermediate':
      case 'intermediário':
        return Colors.orange;
      case 'advanced':
      case 'avançado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
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
          size: 24,
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 16,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

