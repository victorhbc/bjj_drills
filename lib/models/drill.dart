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
  });

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
    };
  }
}
