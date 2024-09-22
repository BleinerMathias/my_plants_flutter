import '../../data/models/plant_model.dart';
import '../../data/repositories/plant_repository.dart';

class GetPlants {
    final PlantRepository repository;

    GetPlants(this.repository);

    Future<List<PlantModel>> call() async {
        return await repository.getPlants();
    }
}
