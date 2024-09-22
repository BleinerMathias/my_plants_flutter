import 'package:flutter/material.dart';
import 'package:my_plantss/data/models/plant_model.dart';
import 'package:my_plantss/data/repositories/plant_repository.dart';

class PlantDetailScreen extends StatelessWidget {
    final int plantId;

    PlantDetailScreen({super.key, required this.plantId});

    final PlantRepository _repository = PlantRepository();

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<PlantModel?>(
            future: _repository.getPlantById(plantId),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(body: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Scaffold(body: Center(child: Text('Erro ao carregar planta')));
                } else {
                    final plant = snapshot.data!;
                    return Scaffold(
                        appBar: AppBar(title: Text(plant.name)),
                        body: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(plant.description, style: const TextStyle(fontSize: 18)),
                                    const SizedBox(height: 16),
                                    Text('Você tem essa planta? ${plant.hasPlant ? "Sim" : "Não"}'),
                                ],
                            ),
                        ),
                    );
                }
            },
        );
    }
}
