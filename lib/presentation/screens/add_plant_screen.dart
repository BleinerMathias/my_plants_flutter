import 'package:flutter/material.dart';
import '../../data/models/plant_model.dart';
import '../../data/repositories/plant_repository.dart';

class AddPlantScreen extends StatefulWidget {
  final VoidCallback onPlantAdded; // Callback para atualizar a lista
  final PlantModel? plant; // Planta para edição (opcional)

  const AddPlantScreen({super.key, required this.onPlantAdded, this.plant});

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _hasPlant = false;

  final PlantRepository _repository = PlantRepository();

  @override
  void initState() {
    super.initState();
    if (widget.plant != null) {
      _nameController.text = widget.plant!.name;
      _descriptionController.text = widget.plant!.description;
      _hasPlant = widget.plant!.hasPlant;
    }
  }

  void _addOrUpdatePlant() async {
    final plant = PlantModel(
      id: widget.plant?.id,
      name: _nameController.text,
      description: _descriptionController.text,
      hasPlant: _hasPlant,
    );

    if (widget.plant == null) {
      await _repository.addPlant(plant);
    } else {
      await _repository.updatePlant(plant);
    }
    Navigator.pop(context, true);
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
      appBar: AppBar(title: const Text('Adicionar ou Editar Planta')),
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
              onPressed: _addOrUpdatePlant,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

