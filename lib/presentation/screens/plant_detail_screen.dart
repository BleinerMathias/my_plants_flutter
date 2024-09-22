import 'package:flutter/material.dart';
import 'package:my_plantss/data/models/plant_model.dart';
import 'package:my_plantss/data/repositories/plant_repository.dart';
import 'package:my_plantss/presentation/screens/add_plant_screen.dart';

class PlantDetailScreen extends StatefulWidget {
    final int plantId;

    const PlantDetailScreen({super.key, required this.plantId});

    @override
    _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
    PlantModel? _plant;

    @override
    void initState() {
        super.initState();
        _loadPlant(); // Carrega a planta na inicialização
    }

    Future<void> _loadPlant() async {
        final plant = await PlantRepository().getPlantById(widget.plantId);
        setState(() {
            _plant = plant;
        });
    }

    @override
    Widget build(BuildContext context) {
        if (_plant == null) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
            appBar: AppBar(
                title: Text(_plant!.name),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                            final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPlantScreen(
                                        onPlantAdded: () {},
                                        plant: _plant,
                                    ),
                                ),
                            );

                            if (updated == true) {
                                _loadPlant();
                            }
                        },
                    ),
                ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(_plant!.description, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        Text('Você tem essa planta? ${_plant!.hasPlant ? "Sim" : "Não"}'),
                    ],
                ),
            ),
        );
    }
}