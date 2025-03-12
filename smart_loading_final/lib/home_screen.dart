import 'package:flutter/material.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  
  void calculateContainer() {
    double length = double.tryParse(lengthController.text) ?? 0;
    double width = double.tryParse(widthController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    String containerSize;
    if (length <= 589 && width <= 235 && height <= 239) {
      containerSize = '20ft Container';
    } else if (length <= 1200 && width <= 235 && height <= 239) {
      containerSize = '40ft Container';
    } else if (length <= 1200 && width <= 235 && height <= 269) {
      containerSize = '40ft High Cube Container';
    } else {
      containerSize = 'Te groot voor standaard containers';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(containerSize: containerSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pallet Afmetingen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Lengte (cm)'),
            ),
            TextField(
              controller: widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Breedte (cm)'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Hoogte (cm)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateContainer,
              child: const Text('Bereken Container'),
            ),
          ],
        ),
      ),
    );
  }
}
