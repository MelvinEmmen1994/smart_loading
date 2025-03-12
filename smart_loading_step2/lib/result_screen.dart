import 'package:flutter/material.dart';
import 'three_d_view.dart';

class ResultScreen extends StatelessWidget {
  final String containerSize;

  const ResultScreen({super.key, required this.containerSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Advies')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Geschikte container: $containerSize',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThreeDView(palletCount: 5),
                  ),
                );
              },
              child: const Text('Bekijk 3D-weergave'),
            ),
          ],
        ),
      ),
    );
  }
}
