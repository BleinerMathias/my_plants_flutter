import '../../../data/repositories/plant_repository.dart';
import '../../../data/models/plant_model.dart';

class GetPlantById {
    final PlantRepository repository;

    GetPlantById(this.repository);

    Future<PlantModel?> call(int id) async {
        return await repository.getPlantById(id);
    }
}
