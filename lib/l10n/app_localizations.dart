import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'BJJ Drills'**
  String get appTitle;

  /// The description of the application
  ///
  /// In en, this message translates to:
  /// **'BJJ Drills - Brazilian Jiu-Jitsu training companion app'**
  String get appDescription;

  /// Welcome message title
  ///
  /// In en, this message translates to:
  /// **'Welcome to BJJ Drills!'**
  String get welcomeTitle;

  /// Welcome message subtitle
  ///
  /// In en, this message translates to:
  /// **'Your Brazilian Jiu-Jitsu training companion'**
  String get welcomeSubtitle;

  /// Hello world message
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// Ready to start message
  ///
  /// In en, this message translates to:
  /// **'Ready to start your BJJ journey?'**
  String get readyToStart;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Welcome snackbar message
  ///
  /// In en, this message translates to:
  /// **'Welcome to BJJ Drills! 🥋'**
  String get welcomeMessage;

  /// Check drills list message
  ///
  /// In en, this message translates to:
  /// **'Check out the Drills List tab! 🥋'**
  String get checkDrillsList;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Drills list tab label
  ///
  /// In en, this message translates to:
  /// **'Drills List'**
  String get drillsList;

  /// Fast training screen title
  ///
  /// In en, this message translates to:
  /// **'Fast Training'**
  String get fastTraining;

  /// Timer configuration screen title
  ///
  /// In en, this message translates to:
  /// **'Timer Configuration'**
  String get timerConfiguration;

  /// Start fast training button text
  ///
  /// In en, this message translates to:
  /// **'Start Fast Training'**
  String get startFastTraining;

  /// Ready to start training message
  ///
  /// In en, this message translates to:
  /// **'Ready to Start Training'**
  String get readyToStartTraining;

  /// Tap start to begin message
  ///
  /// In en, this message translates to:
  /// **'Tap Start to begin your BJJ drill session'**
  String get tapStartToBegin;

  /// No description provided for @drillsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} drills selected'**
  String drillsSelected(Object count);

  /// Drills done label
  ///
  /// In en, this message translates to:
  /// **'Drills Done'**
  String get drillsDone;

  /// Next in label
  ///
  /// In en, this message translates to:
  /// **'Next in'**
  String get nextIn;

  /// Remaining label
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// Round number
  ///
  /// In en, this message translates to:
  /// **'Round {roundNumber}'**
  String round(int roundNumber);

  /// Start button text
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Pause button text
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Resume button text
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// Stop button text
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Training in progress message
  ///
  /// In en, this message translates to:
  /// **'Training in progress...'**
  String get trainingInProgress;

  /// Training paused message
  ///
  /// In en, this message translates to:
  /// **'Training paused'**
  String get trainingPaused;

  /// Interval label
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get interval;

  /// Order label
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// Repeat label
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// Random order
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// Sequential order
  ///
  /// In en, this message translates to:
  /// **'Sequential'**
  String get sequential;

  /// Yes
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Training complete dialog title
  ///
  /// In en, this message translates to:
  /// **'Training Complete!'**
  String get trainingComplete;

  /// Completed drills message
  ///
  /// In en, this message translates to:
  /// **'You completed {count} drills!'**
  String completedDrills(int count);

  /// Completed rounds message
  ///
  /// In en, this message translates to:
  /// **'Completed {rounds} rounds'**
  String completedRounds(int rounds);

  /// Great job message
  ///
  /// In en, this message translates to:
  /// **'Great job on your BJJ training session! 🥋'**
  String get greatJob;

  /// Finish button text
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Beginner difficulty
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// Intermediate difficulty
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// Advanced difficulty
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// All difficulty levels
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Language label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Portuguese language
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// Settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @bjjTakedownDrills.
  ///
  /// In en, this message translates to:
  /// **'BJJ Takedown Drills'**
  String get bjjTakedownDrills;

  /// No description provided for @filterByDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Filter by Difficulty:'**
  String get filterByDifficulty;

  /// No description provided for @takedownDrillsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} takedown drills available'**
  String takedownDrillsAvailable(Object count);

  /// No description provided for @selectDrillsForFastTraining.
  ///
  /// In en, this message translates to:
  /// **'Select Drills for Fast Training'**
  String get selectDrillsForFastTraining;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @fastTrainingSetup.
  ///
  /// In en, this message translates to:
  /// **'Fast Training Setup'**
  String get fastTrainingSetup;

  /// No description provided for @continueToTimerSetup.
  ///
  /// In en, this message translates to:
  /// **'Continue to Timer Setup'**
  String get continueToTimerSetup;

  /// No description provided for @timeInterval.
  ///
  /// In en, this message translates to:
  /// **'Time Interval'**
  String get timeInterval;

  /// No description provided for @howLongBetweenEachDrill.
  ///
  /// In en, this message translates to:
  /// **'How long between each drill announcement'**
  String get howLongBetweenEachDrill;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes:'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds:'**
  String get seconds;

  /// No description provided for @trainingOptions.
  ///
  /// In en, this message translates to:
  /// **'Training Options'**
  String get trainingOptions;

  /// No description provided for @customizeYourTrainingExperience.
  ///
  /// In en, this message translates to:
  /// **'Customize your training experience'**
  String get customizeYourTrainingExperience;

  /// No description provided for @randomOrder.
  ///
  /// In en, this message translates to:
  /// **'Random Order'**
  String get randomOrder;

  /// No description provided for @announceDrillsInRandomOrder.
  ///
  /// In en, this message translates to:
  /// **'Announce drills in random order'**
  String get announceDrillsInRandomOrder;

  /// No description provided for @repeatDrills.
  ///
  /// In en, this message translates to:
  /// **'Repeat Drills'**
  String get repeatDrills;

  /// No description provided for @allowDrillsToBeRepeated.
  ///
  /// In en, this message translates to:
  /// **'Allow drills to be repeated during training'**
  String get allowDrillsToBeRepeated;

  /// No description provided for @selectedDrills.
  ///
  /// In en, this message translates to:
  /// **'Selected Drills'**
  String get selectedDrills;

  /// No description provided for @drillsThatWillBeAnnounced.
  ///
  /// In en, this message translates to:
  /// **'Drills that will be announced during training'**
  String get drillsThatWillBeAnnounced;

  /// No description provided for @andMoreDrills.
  ///
  /// In en, this message translates to:
  /// **'... and {count} more drills'**
  String andMoreDrills(Object count);

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps:'**
  String get steps;

  /// No description provided for @startDrill.
  ///
  /// In en, this message translates to:
  /// **'Start Drill'**
  String get startDrill;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @startingDrill.
  ///
  /// In en, this message translates to:
  /// **'Starting {drillName} drill! 🥋'**
  String startingDrill(Object drillName);

  /// No description provided for @drillAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Drill added to favorites! ⭐'**
  String get drillAddedToFavorites;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @voiceAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Voice Announcements'**
  String get voiceAnnouncements;

  /// No description provided for @enableVoiceAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Enable voice announcements for drill names during training'**
  String get enableVoiceAnnouncements;

  /// No description provided for @voiceAnnouncementsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Voice announcements enabled'**
  String get voiceAnnouncementsEnabled;

  /// No description provided for @voiceAnnouncementsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Voice announcements disabled'**
  String get voiceAnnouncementsDisabled;

  /// No description provided for @drillNamesWillBeSpoken.
  ///
  /// In en, this message translates to:
  /// **'Drill names will be spoken during training'**
  String get drillNamesWillBeSpoken;

  /// No description provided for @onlyVisualDrillCards.
  ///
  /// In en, this message translates to:
  /// **'Only visual drill cards will be shown'**
  String get onlyVisualDrillCards;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
