import 'package:sqflite/sqflite.dart';
import '../database/SQLITE_Plant.dart';
import '../models/plant_model.dart';

class PlantRepository {
  final PlantDatabase _database = PlantDatabase.instance;

  Future<int> addPlant(PlantModel plant) async {
    final db = await _database.database;
    return await db.insert('plants', plant.toMap());
  }

  Future<List<PlantModel>> getPlants() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('plants');
    return List.generate(maps.length, (i) => PlantModel.fromMap(maps[i]));
  }

  Future<PlantModel?> getPlantById(int id) async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('plants', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return PlantModel.fromMap(maps.first);
    }
    return null;
  }
}
