// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'BJJ Drills';

  @override
  String get appDescription =>
      'BJJ Drills - Aplicativo de treinamento de Jiu-Jitsu Brasileiro';

  @override
  String get welcomeTitle => 'Bem-vindo ao BJJ Drills!';

  @override
  String get welcomeSubtitle =>
      'Seu companheiro de treinamento de Jiu-Jitsu Brasileiro';

  @override
  String get helloWorld => 'Olá Mundo!';

  @override
  String get readyToStart => 'Pronto para começar sua jornada no BJJ?';

  @override
  String get getStarted => 'Começar';

  @override
  String get welcomeMessage => 'Bem-vindo ao BJJ Drills! 🥋';

  @override
  String get checkDrillsList => 'Confira a aba Lista de Exercícios! 🥋';

  @override
  String get home => 'Início';

  @override
  String get drillsList => 'Lista de Exercícios';

  @override
  String get fastTraining => 'Treino Rápido';

  @override
  String get timerConfiguration => 'Configuração do Timer';

  @override
  String get startFastTraining => 'Iniciar Treino Rápido';

  @override
  String get readyToStartTraining => 'Pronto para Iniciar o Treino';

  @override
  String get tapStartToBegin =>
      'Toque em Iniciar para começar sua sessão de exercícios de BJJ';

  @override
  String drillsSelected(Object count) {
    return '$count exercícios selecionados';
  }

  @override
  String get drillsDone => 'Exercícios Feitos';

  @override
  String get nextIn => 'Próximo em';

  @override
  String get remaining => 'Restantes';

  @override
  String round(int roundNumber) {
    return 'Round $roundNumber';
  }

  @override
  String get start => 'Iniciar';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Retomar';

  @override
  String get stop => 'Parar';

  @override
  String get trainingInProgress => 'Treino em andamento...';

  @override
  String get trainingPaused => 'Treino pausado';

  @override
  String get interval => 'Intervalo';

  @override
  String get order => 'Ordem';

  @override
  String get repeat => 'Repetir';

  @override
  String get random => 'Aleatório';

  @override
  String get sequential => 'Sequencial';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get trainingComplete => 'Treino Concluído!';

  @override
  String completedDrills(int count) {
    return 'Você completou $count exercícios!';
  }

  @override
  String completedRounds(int rounds) {
    return 'Completou $rounds rounds';
  }

  @override
  String get greatJob => 'Ótimo trabalho na sua sessão de treino de BJJ! 🥋';

  @override
  String get finish => 'Finalizar';

  @override
  String get beginner => 'Iniciante';

  @override
  String get intermediate => 'Intermediário';

  @override
  String get advanced => 'Avançado';

  @override
  String get all => 'Todos';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';

  @override
  String get settings => 'Configurações';

  @override
  String get bjjTakedownDrills => 'Exercícios de Queda do BJJ';

  @override
  String get filterByDifficulty => 'Filtrar por Dificuldade:';

  @override
  String takedownDrillsAvailable(Object count) {
    return '$count exercícios de queda disponíveis';
  }

  @override
  String get selectDrillsForFastTraining =>
      'Selecionar Exercícios para Treino Rápido';

  @override
  String get clearAll => 'Limpar Todos';

  @override
  String get fastTrainingSetup => 'Configuração do Treino Rápido';

  @override
  String get continueToTimerSetup => 'Continuar para Configuração do Timer';

  @override
  String get timeInterval => 'Intervalo de Tempo';

  @override
  String get howLongBetweenEachDrill =>
      'Quanto tempo entre cada anúncio de exercício';

  @override
  String get minutes => 'Minutos:';

  @override
  String get seconds => 'Segundos:';

  @override
  String get trainingOptions => 'Opções de Treino';

  @override
  String get customizeYourTrainingExperience =>
      'Personalize sua experiência de treino';

  @override
  String get randomOrder => 'Ordem Aleatória';

  @override
  String get announceDrillsInRandomOrder =>
      'Anunciar exercícios em ordem aleatória';

  @override
  String get repeatDrills => 'Repetir Exercícios';

  @override
  String get allowDrillsToBeRepeated =>
      'Permitir que exercícios sejam repetidos durante o treino';

  @override
  String get selectedDrills => 'Exercícios Selecionados';

  @override
  String get drillsThatWillBeAnnounced =>
      'Exercícios que serão anunciados durante o treino';

  @override
  String andMoreDrills(Object count) {
    return '... e mais $count exercícios';
  }

  @override
  String get steps => 'Passos:';

  @override
  String get startDrill => 'Iniciar Exercício';

  @override
  String get favorite => 'Favorito';

  @override
  String startingDrill(Object drillName) {
    return 'Iniciando exercício $drillName! 🥋';
  }

  @override
  String get drillAddedToFavorites => 'Exercício adicionado aos favoritos! ⭐';

  @override
  String get min => 'min';

  @override
  String get totalTime => 'Tempo Total';

  @override
  String get voiceAnnouncements => 'Anúncios por Voz';

  @override
  String get enableVoiceAnnouncements =>
      'Habilitar anúncios por voz para nomes de exercícios durante o treino';

  @override
  String get voiceAnnouncementsEnabled => 'Anúncios por voz habilitados';

  @override
  String get voiceAnnouncementsDisabled => 'Anúncios por voz desabilitados';

  @override
  String get drillNamesWillBeSpoken =>
      'Nomes dos exercícios serão falados durante o treino';

  @override
  String get onlyVisualDrillCards =>
      'Apenas cartões visuais dos exercícios serão mostrados';
}
