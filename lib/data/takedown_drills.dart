import '../models/drill.dart';

class TakedownDrills {
  static const List<Drill> drills = [
    Drill(
      id: 'single_leg_takedown',
      name: 'Single Leg Takedown',
      description: 'A fundamental takedown where you grab one leg and drive forward to bring your opponent down.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 15,
      steps: [
        'Set up with a collar tie or underhook',
        'Shoot in and grab the opponent\'s leg at the knee',
        'Drive forward with your shoulder into their hip',
        'Lift and drive them to the ground',
        'Maintain control and transition to ground position'
      ],
      descriptionPt: 'Uma queda fundamental onde você agarra uma perna e avança para derrubar seu oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Configure com uma pegada no colarinho ou gancho por baixo',
        'Entre e agarre a perna do oponente no joelho',
        'Avance com seu ombro contra o quadril dele',
        'Levante e empurre-o ao chão',
        'Mantenha o controle e transicione para posição no chão'
      ],
    ),
    Drill(
      id: 'double_leg_takedown',
      name: 'Double Leg Takedown',
      description: 'A powerful takedown that involves grabbing both legs and driving through your opponent.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 15,
      steps: [
        'Set up with proper stance and distance',
        'Shoot in with your head up and back straight',
        'Grab both legs at the knees',
        'Drive forward with your shoulder into their hip',
        'Lift and drive them to the ground',
        'Secure top position'
      ],
      descriptionPt: 'Uma queda poderosa que envolve agarrar ambas as pernas e avançar através do oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Configure com postura e distância adequadas',
        'Entre com a cabeça erguida e costas retas',
        'Agarre ambas as pernas nos joelhos',
        'Avance com seu ombro contra o quadril dele',
        'Levante e empurre-o ao chão',
        'Garanta a posição superior'
      ],
    ),
    Drill(
      id: 'hip_toss',
      name: 'Hip Toss (O Goshi)',
      description: 'A classic judo throw adapted for BJJ, using your hip as a fulcrum to throw your opponent.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 20,
      steps: [
        'Get a collar tie and underhook',
        'Step in close and turn your hip into their hip',
        'Pull down on the collar while lifting with the underhook',
        'Use your hip as a fulcrum to throw them over',
        'Follow them to the ground and secure position'
      ],
      descriptionPt: 'Um arremesso clássico do judô adaptado para o BJJ, usando seu quadril como ponto de apoio para arremessar o oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre próximo e vire seu quadril contra o quadril dele',
        'Puxe para baixo no colarinho enquanto levanta com o gancho',
        'Use seu quadril como ponto de apoio para arremessá-lo',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
    Drill(
      id: 'foot_sweep',
      name: 'Foot Sweep (De Ashi Barai)',
      description: 'A timing-based sweep that catches your opponent off-balance.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 15,
      steps: [
        'Grip the opponent\'s gi or body',
        'Wait for them to step forward',
        'Sweep their foot with your foot as they step',
        'Pull them in the direction of the sweep',
        'Follow them down and secure position'
      ],
      descriptionPt: 'Uma varredura baseada em timing que pega o oponente desequilibrado.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Agarre o kimono ou corpo do oponente',
        'Aguarde ele dar um passo à frente',
        'Varra o pé dele com seu pé quando ele pisar',
        'Puxe-o na direção da varredura',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
    Drill(
      id: 'ankle_pick',
      name: 'Ankle Pick',
      description: 'A quick takedown that targets the ankle when your opponent is off-balance.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 10,
      steps: [
        'Set up with a collar tie',
        'Pull down on the collar to off-balance them',
        'Quickly reach down and grab their ankle',
        'Pull the ankle up and push them backward',
        'Follow them down and secure position'
      ],
      descriptionPt: 'Uma queda rápida que mira no tornozelo quando o oponente está desequilibrado.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Configure com uma pegada no colarinho',
        'Puxe para baixo no colarinho para desequilibrá-lo',
        'Rapidamente alcance e agarre o tornozelo dele',
        'Puxe o tornozelo para cima e empurre-o para trás',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
    Drill(
      id: 'knee_tap',
      name: 'Knee Tap',
      description: 'A simple but effective takedown that uses the knee as a target.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 12,
      steps: [
        'Get a collar tie and underhook',
        'Step in and place your hand on their knee',
        'Push down on the knee while pulling up with the underhook',
        'Drive them backward and down',
        'Secure top position'
      ],
      descriptionPt: 'Uma queda simples mas eficaz que usa o joelho como alvo.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e coloque sua mão no joelho dele',
        'Empurre o joelho para baixo enquanto puxa para cima com o gancho',
        'Empurre-o para trás e para baixo',
        'Garanta a posição superior'
      ],
    ),
    Drill(
      id: 'fireman_carry',
      name: 'Fireman\'s Carry',
      description: 'A dynamic takedown that involves lifting your opponent over your shoulder.',
      category: 'Takedowns',
      difficulty: 'Advanced',
      estimatedTime: 25,
      steps: [
        'Get an underhook and control their arm',
        'Step in and duck under their arm',
        'Lift them onto your shoulders',
        'Drive forward and throw them over',
        'Land in a dominant position'
      ],
      descriptionPt: 'Uma queda dinâmica que envolve levantar o oponente sobre seu ombro.',
      categoryPt: 'Quedas',
      difficultyPt: 'Avançado',
      stepsPt: [
        'Obtenha um gancho por baixo e controle o braço dele',
        'Entre e mergulhe sob o braço dele',
        'Levante-o sobre seus ombros',
        'Avance e arremesse-o por cima',
        'Aterrisse em uma posição dominante'
      ],
    ),
    Drill(
      id: 'lateral_drop',
      name: 'Lateral Drop',
      description: 'A powerful throw that uses your body weight to bring your opponent down.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 20,
      steps: [
        'Get a collar tie and underhook',
        'Step in and turn your body perpendicular to theirs',
        'Drop your weight and pull them over your hip',
        'Use your body as a fulcrum',
        'Follow them down and secure position'
      ],
      descriptionPt: 'Um arremesso poderoso que usa seu peso corporal para derrubar o oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e vire seu corpo perpendicular ao dele',
        'Deixe seu peso cair e puxe-o sobre seu quadril',
        'Use seu corpo como ponto de apoio',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
    Drill(
      id: 'snap_down',
      name: 'Snap Down',
      description: 'A quick takedown that uses a sudden downward motion to bring your opponent to their knees.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 10,
      steps: [
        'Get a collar tie with both hands',
        'Pull down sharply on the collar',
        'Step back to create distance',
        'Drive them down to their knees',
        'Transition to a front headlock or back control'
      ],
      descriptionPt: 'Uma queda rápida que usa um movimento súbito para baixo para levar o oponente aos joelhos.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Obtenha uma pegada no colarinho com ambas as mãos',
        'Puxe para baixo bruscamente no colarinho',
        'Dê um passo para trás para criar distância',
        'Empurre-o para baixo até os joelhos',
        'Transicione para uma chave de cabeça frontal ou controle das costas'
      ],
    ),
    Drill(
      id: 'arm_drag',
      name: 'Arm Drag to Takedown',
      description: 'A technique that uses the arm drag to set up various takedowns.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 18,
      steps: [
        'Grab their wrist and pull across your body',
        'Step in and get behind them',
        'Use the momentum to take them down',
        'Secure back control or side control',
        'Transition to a dominant position'
      ],
      descriptionPt: 'Uma técnica que usa o arrasto do braço para configurar várias quedas.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Agarre o pulso dele e puxe através do seu corpo',
        'Entre e fique atrás dele',
        'Use o momentum para derrubá-lo',
        'Garanta controle das costas ou lateral',
        'Transicione para uma posição dominante'
      ],
    ),
    Drill(
      id: 'collar_drag',
      name: 'Collar Drag',
      description: 'A gi-based takedown that uses the collar to control and take down your opponent.',
      category: 'Takedowns',
      difficulty: 'Beginner',
      estimatedTime: 12,
      steps: [
        'Grab the collar with a strong grip',
        'Pull down and across your body',
        'Step in and use your body weight',
        'Drive them to the ground',
        'Secure top position'
      ],
      descriptionPt: 'Uma queda baseada no kimono que usa o colarinho para controlar e derrubar o oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Iniciante',
      stepsPt: [
        'Agarre o colarinho com uma pegada forte',
        'Puxe para baixo e através do seu corpo',
        'Entre e use seu peso corporal',
        'Empurre-o ao chão',
        'Garanta a posição superior'
      ],
    ),
    Drill(
      id: 'sacrifice_throw',
      name: 'Sacrifice Throw (Tomoe Nage)',
      description: 'A sacrifice technique where you fall backward to throw your opponent over you.',
      category: 'Takedowns',
      difficulty: 'Advanced',
      estimatedTime: 22,
      steps: [
        'Get a collar tie and underhook',
        'Step in and fall backward',
        'Use your foot to lift them over you',
        'Throw them over your head',
        'Quickly get up and secure position'
      ],
      descriptionPt: 'Uma técnica de sacrifício onde você cai para trás para arremessar o oponente sobre você.',
      categoryPt: 'Quedas',
      difficultyPt: 'Avançado',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e caia para trás',
        'Use seu pé para levantá-lo sobre você',
        'Arremesse-o sobre sua cabeça',
        'Rapidamente levante-se e garanta a posição'
      ],
    ),
    Drill(
      id: 'uchi_mata',
      name: 'Uchi Mata (Inner Thigh Throw)',
      description: 'A powerful judo throw that uses the inner thigh to throw your opponent.',
      category: 'Takedowns',
      difficulty: 'Advanced',
      estimatedTime: 25,
      steps: [
        'Get a collar tie and underhook',
        'Step in and turn your hip into theirs',
        'Lift with your leg on their inner thigh',
        'Pull down with the collar and lift with the underhook',
        'Throw them over your hip and follow them down'
      ],
      descriptionPt: 'Um arremesso poderoso do judô que usa a parte interna da coxa para arremessar o oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Avançado',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e vire seu quadril contra o dele',
        'Levante com sua perna na parte interna da coxa dele',
        'Puxe para baixo com o colarinho e levante com o gancho',
        'Arremesse-o sobre seu quadril e siga-o ao chão'
      ],
    ),
    Drill(
      id: 'osoto_gari',
      name: 'Osoto Gari (Major Outer Reap)',
      description: 'A powerful outer leg reap that sweeps your opponent\'s leg out from under them.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 18,
      steps: [
        'Get a collar tie and underhook',
        'Step in and turn your body',
        'Reap their leg with your leg',
        'Pull them backward and down',
        'Follow them down and secure position'
      ],
      descriptionPt: 'Uma ceifa poderosa da perna externa que varre a perna do oponente de baixo dele.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e vire seu corpo',
        'Ceife a perna dele com sua perna',
        'Puxe-o para trás e para baixo',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
    Drill(
      id: 'koshi_guruma',
      name: 'Koshi Guruma (Hip Wheel)',
      description: 'A hip-based throw that uses your hip as a wheel to throw your opponent.',
      category: 'Takedowns',
      difficulty: 'Intermediate',
      estimatedTime: 20,
      steps: [
        'Get a collar tie and underhook',
        'Step in and turn your hip into theirs',
        'Use your hip as a fulcrum',
        'Pull them over your hip',
        'Follow them down and secure position'
      ],
      descriptionPt: 'Um arremesso baseado no quadril que usa seu quadril como uma roda para arremessar o oponente.',
      categoryPt: 'Quedas',
      difficultyPt: 'Intermediário',
      stepsPt: [
        'Obtenha uma pegada no colarinho e gancho por baixo',
        'Entre e vire seu quadril contra o dele',
        'Use seu quadril como ponto de apoio',
        'Puxe-o sobre seu quadril',
        'Siga-o ao chão e garanta a posição'
      ],
    ),
  ];

  static List<Drill> getDrillsByDifficulty(String difficulty) {
    return drills.where((drill) => drill.difficulty == difficulty).toList();
  }

  static List<Drill> getDrillsByCategory(String category) {
    return drills.where((drill) => drill.category == category).toList();
  }

  static Drill? getDrillById(String id) {
    try {
      return drills.firstWhere((drill) => drill.id == id);
    } catch (e) {
      return null;
    }
  }
}
