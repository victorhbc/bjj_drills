class Drill {
  final String id;
  final String name;
  final String description;
  final String category;
  final String difficulty; // Beginner, Intermediate, Advanced
  final int estimatedTime; // in minutes
  final List<String> steps;
  final String? videoUrl;
  final String? imageUrl;
  
  // Portuguese translations
  final String? descriptionPt;
  final String? categoryPt;
  final String? difficultyPt;
  final List<String>? stepsPt;

  const Drill({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedTime,
    required this.steps,
    this.videoUrl,
    this.imageUrl,
    this.descriptionPt,
    this.categoryPt,
    this.difficultyPt,
    this.stepsPt,
  });

  // Methods to get translated content
  String getTranslatedDescription(String languageCode) {
    if (languageCode == 'pt' && descriptionPt != null) {
      return descriptionPt!;
    }
    return description;
  }
  
  String getTranslatedCategory(String languageCode) {
    if (languageCode == 'pt' && categoryPt != null) {
      return categoryPt!;
    }
    return category;
  }
  
  String getTranslatedDifficulty(String languageCode) {
    if (languageCode == 'pt' && difficultyPt != null) {
      return difficultyPt!;
    }
    return difficulty;
  }
  
  List<String> getTranslatedSteps(String languageCode) {
    if (languageCode == 'pt' && stepsPt != null) {
      return stepsPt!;
    }
    return steps;
  }

  factory Drill.fromJson(Map<String, dynamic> json) {
    return Drill(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      estimatedTime: json['estimatedTime'] as int,
      steps: List<String>.from(json['steps'] as List),
      videoUrl: json['videoUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      descriptionPt: json['descriptionPt'] as String?,
      categoryPt: json['categoryPt'] as String?,
      difficultyPt: json['difficultyPt'] as String?,
      stepsPt: json['stepsPt'] != null ? List<String>.from(json['stepsPt'] as List) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'steps': steps,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'descriptionPt': descriptionPt,
      'categoryPt': categoryPt,
      'difficultyPt': difficultyPt,
      'stepsPt': stepsPt,
    };
  }
}
