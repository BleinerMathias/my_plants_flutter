import '../../../data/repositories/plant_repository.dart';
import '../../../data/models/plant_model.dart';

class AddPlant {
    final PlantRepository repository;

    AddPlant(this.repository);

    Future<void> call(PlantModel plant) async {
        await repository.addPlant(plant);
    }
}
