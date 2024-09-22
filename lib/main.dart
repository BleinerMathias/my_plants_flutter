import 'package:flutter/material.dart';
import 'package:my_plantss/presentation/screens/plant_list_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Plants',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PlantListScreen(),
    );
  }
}
