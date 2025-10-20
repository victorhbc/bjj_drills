import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../services/tts_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TTSService _ttsService = TTSService();
  bool _ttsEnabled = true;
  bool _ttsAvailable = false;

  @override
  void initState() {
    super.initState();
    _loadTTSSettings();
  }

  Future<void> _loadTTSSettings() async {
    await _ttsService.initialize();
    setState(() {
      _ttsEnabled = _ttsService.isEnabled;
      _ttsAvailable = _ttsService.isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.language,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLanguageOption(
                      context,
                      l10n.english,
                      'en',
                      Icons.flag,
                    ),
                    const SizedBox(height: 8),
                    _buildLanguageOption(
                      context,
                      l10n.portuguese,
                      'pt',
                      Icons.flag,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Theme Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Theme',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildThemeOption(
                      context,
                      'Light',
                      ThemeMode.light,
                      Icons.light_mode,
                    ),
                    const SizedBox(height: 8),
                    _buildThemeOption(
                      context,
                      'Dark',
                      ThemeMode.dark,
                      Icons.dark_mode,
                    ),
                    const SizedBox(height: 8),
                    _buildThemeOption(
                      context,
                      'System',
                      ThemeMode.system,
                      Icons.settings_system_daydream,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // TTS Settings Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.volume_up,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.voiceAnnouncements,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.enableVoiceAnnouncements,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TTS Status indicator
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _ttsAvailable 
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _ttsAvailable 
                              ? Colors.green.withValues(alpha: 0.3)
                              : Colors.red.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _ttsAvailable ? Icons.check_circle : Icons.error,
                            color: _ttsAvailable ? Colors.green : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _ttsAvailable 
                                ? 'TTS is available on this device'
                                : 'TTS is not available on this device',
                            style: TextStyle(
                              color: _ttsAvailable ? Colors.green : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        _ttsEnabled ? l10n.voiceAnnouncementsEnabled : l10n.voiceAnnouncementsDisabled,
                        style: TextStyle(
                          color: _ttsEnabled 
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        _ttsEnabled 
                            ? l10n.drillNamesWillBeSpoken
                            : l10n.onlyVisualDrillCards,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: _ttsEnabled,
                      onChanged: (value) async {
                        setState(() {
                          _ttsEnabled = value;
                        });
                        await _ttsService.setEnabled(value);
                        
                        // Test TTS if enabling
                        if (value) {
                          _ttsService.speak('Voice announcements enabled');
                        }
                      },
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    // Test TTS button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _ttsAvailable && _ttsEnabled ? _testTTS : null,
                        icon: const Icon(Icons.volume_up),
                        label: const Text('Test Voice Announcement'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // App Info Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'App Info',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.appDescription,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version 1.0.0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String themeName,
    ThemeMode themeMode,
    IconData icon,
  ) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isSelected = themeProvider.themeMode == themeMode;
    
        return InkWell(
          onTap: () {
            _changeTheme(context, themeMode);
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected 
                  ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  themeName,
                  style: TextStyle(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[800],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageName,
    String languageCode,
    IconData icon,
  ) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isSelected = languageProvider.currentLanguageCode == languageCode;
    
        return InkWell(
          onTap: () {
            _changeLanguage(context, languageCode);
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected 
                  ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  languageName,
                  style: TextStyle(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[800],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.changeLanguage(languageCode);
    
    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          languageCode == 'en' 
              ? 'Language changed to English' 
              : 'Idioma alterado para Português',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _changeTheme(BuildContext context, ThemeMode themeMode) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.setThemeMode(themeMode);
    
    // Show a success message
    String themeName;
    switch (themeMode) {
      case ThemeMode.light:
        themeName = 'Light';
        break;
      case ThemeMode.dark:
        themeName = 'Dark';
        break;
      case ThemeMode.system:
        themeName = 'System';
        break;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme changed to $themeName'),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void> _testTTS() async {
    try {
      final success = await _ttsService.testTTS();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success 
                  ? 'TTS test successful! You should hear the announcement.'
                  : 'TTS test failed. Check device settings.',
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: success 
                ? Colors.green 
                : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('TTS test error: $e'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
