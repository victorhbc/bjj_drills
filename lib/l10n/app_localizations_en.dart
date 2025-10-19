// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BJJ Drills';

  @override
  String get appDescription =>
      'BJJ Drills - Brazilian Jiu-Jitsu training companion app';

  @override
  String get welcomeTitle => 'Welcome to BJJ Drills!';

  @override
  String get welcomeSubtitle => 'Your Brazilian Jiu-Jitsu training companion';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get readyToStart => 'Ready to start your BJJ journey?';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeMessage => 'Welcome to BJJ Drills! 🥋';

  @override
  String get checkDrillsList => 'Check out the Drills List tab! 🥋';

  @override
  String get home => 'Home';

  @override
  String get drillsList => 'Drills List';

  @override
  String get fastTraining => 'Fast Training';

  @override
  String get timerConfiguration => 'Timer Configuration';

  @override
  String get startFastTraining => 'Start Fast Training';

  @override
  String get readyToStartTraining => 'Ready to Start Training';

  @override
  String get tapStartToBegin => 'Tap Start to begin your BJJ drill session';

  @override
  String drillsSelected(Object count) {
    return '$count drills selected';
  }

  @override
  String get drillsDone => 'Drills Done';

  @override
  String get nextIn => 'Next in';

  @override
  String get remaining => 'Remaining';

  @override
  String round(int roundNumber) {
    return 'Round $roundNumber';
  }

  @override
  String get start => 'Start';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get stop => 'Stop';

  @override
  String get trainingInProgress => 'Training in progress...';

  @override
  String get trainingPaused => 'Training paused';

  @override
  String get interval => 'Interval';

  @override
  String get order => 'Order';

  @override
  String get repeat => 'Repeat';

  @override
  String get random => 'Random';

  @override
  String get sequential => 'Sequential';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get trainingComplete => 'Training Complete!';

  @override
  String completedDrills(int count) {
    return 'You completed $count drills!';
  }

  @override
  String completedRounds(int rounds) {
    return 'Completed $rounds rounds';
  }

  @override
  String get greatJob => 'Great job on your BJJ training session! 🥋';

  @override
  String get finish => 'Finish';

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get advanced => 'Advanced';

  @override
  String get all => 'All';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';

  @override
  String get settings => 'Settings';

  @override
  String get bjjTakedownDrills => 'BJJ Takedown Drills';

  @override
  String get filterByDifficulty => 'Filter by Difficulty:';

  @override
  String takedownDrillsAvailable(Object count) {
    return '$count takedown drills available';
  }

  @override
  String get selectDrillsForFastTraining => 'Select Drills for Fast Training';

  @override
  String get clearAll => 'Clear All';

  @override
  String get fastTrainingSetup => 'Fast Training Setup';

  @override
  String get continueToTimerSetup => 'Continue to Timer Setup';

  @override
  String get timeInterval => 'Time Interval';

  @override
  String get howLongBetweenEachDrill =>
      'How long between each drill announcement';

  @override
  String get minutes => 'Minutes:';

  @override
  String get seconds => 'Seconds:';

  @override
  String get trainingOptions => 'Training Options';

  @override
  String get customizeYourTrainingExperience =>
      'Customize your training experience';

  @override
  String get randomOrder => 'Random Order';

  @override
  String get announceDrillsInRandomOrder => 'Announce drills in random order';

  @override
  String get repeatDrills => 'Repeat Drills';

  @override
  String get allowDrillsToBeRepeated =>
      'Allow drills to be repeated during training';

  @override
  String get selectedDrills => 'Selected Drills';

  @override
  String get drillsThatWillBeAnnounced =>
      'Drills that will be announced during training';

  @override
  String andMoreDrills(Object count) {
    return '... and $count more drills';
  }

  @override
  String get steps => 'Steps:';

  @override
  String get startDrill => 'Start Drill';

  @override
  String get favorite => 'Favorite';

  @override
  String startingDrill(Object drillName) {
    return 'Starting $drillName drill! 🥋';
  }

  @override
  String get drillAddedToFavorites => 'Drill added to favorites! ⭐';

  @override
  String get min => 'min';

  @override
  String get totalTime => 'Total Time';
}
