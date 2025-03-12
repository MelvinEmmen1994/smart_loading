import 'package:flutter/material.dart';
import 'dart:math';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String syncCode = "";

  void generateSyncCode() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random();
    setState(() {
      syncCode = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Synchronisatie")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(syncCode.isNotEmpty ? "Jouw synchronisatiecode: $syncCode" : "Klik op de knop om een code te genereren",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateSyncCode,
              child: const Text("Genereer code"),
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: const InputDecoration(
                labelText: "Voer een synchronisatiecode in",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Synchroniseer"),
            ),
          ],
        ),
      ),
    );
  }
}
