import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isEnabled = true;
  bool _isInitialized = false;
  bool _isAvailable = false;

  bool get isEnabled => _isEnabled;
  bool get isInitialized => _isInitialized;
  bool get isAvailable => _isAvailable;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      if (kDebugMode) {
        print('TTS: Starting initialization...');
      }

      // Check if TTS is available on the device
      _isAvailable = await _flutterTts.isLanguageAvailable("en-US");
      if (kDebugMode) {
        print('TTS: Available: $_isAvailable');
      }

      if (!_isAvailable) {
        if (kDebugMode) {
          print('TTS: Not available on this device');
        }
        _isEnabled = false;
        _isInitialized = true;
        return;
      }

      // Get available languages for debugging
      final languages = await _flutterTts.getLanguages;
      if (kDebugMode) {
        print('TTS: Available languages: $languages');
      }

      // Configure TTS settings
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.5); // Slower speech rate for clarity
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      // Set up completion handler
      _flutterTts.setCompletionHandler(() {
        if (kDebugMode) {
          print('TTS: Speech completed');
        }
      });

      // Set up error handler
      _flutterTts.setErrorHandler((msg) {
        if (kDebugMode) {
          print('TTS Error: $msg');
        }
      });

      // Set up start handler
      _flutterTts.setStartHandler(() {
        if (kDebugMode) {
          print('TTS: Speech started');
        }
      });

      // Load saved TTS preference
      await _loadTTSPreference();

      _isInitialized = true;
      
      if (kDebugMode) {
        print('TTS: Initialization completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TTS Initialization Error: $e');
      }
      _isEnabled = false;
      _isInitialized = true;
    }
  }

  Future<void> _loadTTSPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isEnabled = prefs.getBool('tts_enabled') ?? true;
    } catch (e) {
      print('Error loading TTS preference: $e');
      _isEnabled = true; // Default to enabled
    }
  }

  Future<void> _saveTTSPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('tts_enabled', _isEnabled);
    } catch (e) {
      print('Error saving TTS preference: $e');
    }
  }

  Future<void> setEnabled(bool enabled) async {
    _isEnabled = enabled;
    await _saveTTSPreference();
  }

  Future<void> speak(String text) async {
    if (kDebugMode) {
      print('TTS: Attempting to speak: "$text"');
      print('TTS: Enabled: $_isEnabled, Initialized: $_isInitialized, Available: $_isAvailable');
    }

    if (!_isEnabled || !_isInitialized || !_isAvailable || text.isEmpty) {
      if (kDebugMode) {
        print('TTS: Cannot speak - conditions not met');
      }
      return;
    }

    try {
      // Stop any current speech
      await _flutterTts.stop();
      
      // Small delay to ensure stop is processed
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Speak the text
      final result = await _flutterTts.speak(text);
      
      if (kDebugMode) {
        print('TTS: Speak result: $result');
      }
    } catch (e) {
      if (kDebugMode) {
        print('TTS Speak Error: $e');
      }
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      print('TTS Stop Error: $e');
    }
  }

  Future<void> setLanguage(String languageCode) async {
    try {
      String ttsLanguage;
      switch (languageCode) {
        case 'pt':
          ttsLanguage = "pt-BR"; // Brazilian Portuguese
          break;
        case 'en':
        default:
          ttsLanguage = "en-US"; // US English
          break;
      }
      
      if (kDebugMode) {
        print('TTS: Setting language to: $ttsLanguage');
      }
      
      // Check if language is available before setting
      final isAvailable = await _flutterTts.isLanguageAvailable(ttsLanguage);
      if (kDebugMode) {
        print('TTS: Language $ttsLanguage available: $isAvailable');
      }
      
      if (isAvailable) {
        await _flutterTts.setLanguage(ttsLanguage);
        if (kDebugMode) {
          print('TTS: Language set successfully');
        }
      } else {
        if (kDebugMode) {
          print('TTS: Language $ttsLanguage not available, falling back to en-US');
        }
        await _flutterTts.setLanguage("en-US");
      }
    } catch (e) {
      if (kDebugMode) {
        print('TTS Language Error: $e');
      }
    }
  }

  Future<List<dynamic>> getAvailableLanguages() async {
    try {
      return await _flutterTts.getLanguages;
    } catch (e) {
      print('TTS Get Languages Error: $e');
      return [];
    }
  }

  Future<bool> testTTS() async {
    if (!_isEnabled || !_isInitialized || !_isAvailable) {
      return false;
    }

    try {
      await speak('TTS test successful');
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('TTS Test Error: $e');
      }
      return false;
    }
  }

  Future<void> dispose() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      if (kDebugMode) {
        print('TTS Dispose Error: $e');
      }
    }
  }
}
