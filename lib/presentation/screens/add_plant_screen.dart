import 'package:flutter/material.dart';
import '../../data/models/plant_model.dart';
import '../../data/repositories/plant_repository.dart';

class AddPlantScreen extends StatefulWidget {
  final VoidCallback onPlantAdded; // Callback para atualizar a lista

  const AddPlantScreen({super.key, required this.onPlantAdded});

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _hasPlant = false;

  final PlantRepository _repository = PlantRepository();

  void _addPlant() async {
    final plant = PlantModel(
      name: _nameController.text,
      description: _descriptionController.text,
      hasPlant: _hasPlant,
    );

    await _repository.addPlant(plant);
    widget.onPlantAdded(); // Chama o callback para atualizar a lista
    Navigator.pop(context); // Volta para a tela anterior
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Planta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da Planta'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            SwitchListTile(
              title: const Text('Você tem essa planta?'),
              value: _hasPlant,
              onChanged: (bool value) {
                setState(() {
                  _hasPlant = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addPlant,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
