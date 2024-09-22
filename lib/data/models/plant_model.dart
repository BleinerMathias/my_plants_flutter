class PlantModel {
  final int? id;
  final String name;
  final String description;
  final bool hasPlant;

  PlantModel({this.id, required this.name, required this.description, required this.hasPlant});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'hasPlant': hasPlant ? 1 : 0, // Armazena como 1 ou 0
    };
  }

  static PlantModel fromMap(Map<String, dynamic> map) {
    return PlantModel(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    hasPlant: map['hasPlant'] == 1,
    );
  }

}