import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  TextEditingController codeController = TextEditingController();
  String syncStatus = "";

  Future<void> syncData() async {
    String syncCode = codeController.text.trim();
    if (syncCode.isEmpty) {
      setState(() {
        syncStatus = "Voer een geldige code in.";
      });
      return;
    }

    // Simulatie van een API-aanroep naar een server
    try {
      var response = await http.get(Uri.parse("https://example.com/sync/$syncCode"));
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("synced_data", response.body);
        setState(() {
          syncStatus = "Synchronisatie geslaagd!";
        });
      } else {
        setState(() {
          syncStatus = "Ongeldige code of geen data gevonden.";
        });
      }
    } catch (e) {
      setState(() {
        syncStatus = "Fout bij synchroniseren.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synchroniseer met code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Voer synchronisatiecode in"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: syncData,
              child: const Text("Synchroniseer"),
            ),
            const SizedBox(height: 20),
            Text(syncStatus),
          ],
        ),
      ),
    );
  }
}
