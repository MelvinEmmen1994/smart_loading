import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String containerSize;

  const ResultScreen({super.key, required this.containerSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Advies')),
      body: Center(
        child: Text(
          'Geschikte container: $containerSize',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
