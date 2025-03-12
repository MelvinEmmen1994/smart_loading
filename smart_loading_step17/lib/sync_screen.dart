import 'dart:math';
import 'package:flutter/material.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String syncCode = "";

  void _generateSyncCode() {
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random();
    setState(() {
      syncCode = List.generate(8, (index) => characters[random.nextInt(characters.length)]).join();
    });
  }

  void _syncWithCode(String code) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gesynchroniseerd met code: $code")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Synchronisatie")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _generateSyncCode,
              child: const Text("Genereer synchronisatiecode"),
            ),
            if (syncCode.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("Uw code: $syncCode", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            TextField(
              decoration: const InputDecoration(labelText: "Voer synchronisatiecode in"),
              onSubmitted: _syncWithCode,
            ),
          ],
        ),
      ),
    );
  }
}
