import '../../../data/repositories/plant_repository.dart';
import '../../../data/models/plant_model.dart';

class GetPlants {
    final PlantRepository repository;

    GetPlants(this.repository);

    Future<List<PlantModel>> call() async {
        return await repository.getPlants();
    }
}
