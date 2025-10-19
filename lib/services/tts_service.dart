import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isEnabled = true;
  bool _isInitialized = false;

  bool get isEnabled => _isEnabled;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configure TTS settings
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.5); // Slower speech rate for clarity
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      // Set up completion handler
      _flutterTts.setCompletionHandler(() {
        // TTS completed
      });

      // Set up error handler
      _flutterTts.setErrorHandler((msg) {
        print('TTS Error: $msg');
      });

      // Load saved TTS preference
      await _loadTTSPreference();

      _isInitialized = true;
    } catch (e) {
      print('TTS Initialization Error: $e');
      _isEnabled = false;
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
    if (!_isEnabled || !_isInitialized || text.isEmpty) return;

    try {
      await _flutterTts.stop(); // Stop any current speech
      await _flutterTts.speak(text);
    } catch (e) {
      print('TTS Speak Error: $e');
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
      await _flutterTts.setLanguage(ttsLanguage);
    } catch (e) {
      print('TTS Language Error: $e');
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

  Future<void> dispose() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      print('TTS Dispose Error: $e');
    }
  }
}
