import 'package:flutter/material.dart';
import 'package:my_plantss/data/models/plant_model.dart';
import 'package:my_plantss/data/repositories/plant_repository.dart';
import 'package:my_plantss/presentation/widgets/plant_card.dart';
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

    void _deletePlant(int id) async {
        final result = await showDialog<bool>(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Deletar Planta'),
                    content: const Text('Tem certeza que deseja deletar esta planta?'),
                    actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                        ),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Deletar'),
                        ),
                    ],
                );
            },
        );

        if (result == true) {
            await _repository.deletePlant(id);
            _loadPlants(); // Atualiza a lista após a deleção
        }
    }


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Lista de Plantas')),
            body: ListView.builder(
                itemCount: plants.length,
                itemBuilder: (context, index) {
                    final plant = plants[index];
                    return PlantCard(
                        plant: plant,
                        onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlantDetailScreen(plantId: plant.id!),
                                ),
                            );
                        },
                        onDelete: () {
                            _deletePlant(plant.id!);
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
