import 'package:flutter/material.dart';
import 'package:my_plantss/data/models/plant_model.dart';
import 'package:my_plantss/data/repositories/plant_repository.dart';
import 'add_plant_screen.dart';
import 'plant_detail_screen.dart';

class PlantListScreen extends StatefulWidget {
    @override
    _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
    List<PlantModel> plants = [];
    final PlantRepository _repository = PlantRepository();

    @override
    void initState() {
        super.initState();
        _loadPlants(); // Carrega as plantas ao iniciar
    }

    void _loadPlants() async {
        final fetchedPlants = await _repository.getPlants();
        setState(() {
            plants = fetchedPlants; // Atualiza a lista de plantas
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Lista de Plantas')),
            body: ListView.builder(
                itemCount: plants.length,
                itemBuilder: (context, index) {
                    final plant = plants[index];
                    return ListTile(
                        title: Text(plant.name),
                        subtitle: Text(plant.description),
                        onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlantDetailScreen(plantId: plant.id!),
                                ),
                            );
                        },
                    );
                },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlantScreen(
                                onPlantAdded: _loadPlants,
                            ),
                        ),
                    );
                    _loadPlants();
                },
                child: Icon(Icons.add),
            ),
        );
    }
}
