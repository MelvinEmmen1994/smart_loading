import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final TextEditingController codeController = TextEditingController();
  List<Map<String, String>> pallets = [];
  String syncCode = "";

  Future<void> generateSyncCode() async {
    final response = await http.post(
      Uri.parse("https://example.com/api/generate_code"), // API-endpoint
    );

    if (response.statusCode == 200) {
      setState(() {
        syncCode = jsonDecode(response.body)["code"];
      });
    }
  }

  Future<void> syncData() async {
    final response = await http.get(
      Uri.parse("https://example.com/api/get_data?code=${codeController.text}"), // API-endpoint
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["pallets"];
      setState(() {
        pallets = data.map((item) => {
          "ID": item["id"],
          "Breedte": item["width"],
          "Hoogte": item["height"],
          "Lengte": item["length"],
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Code niet gevonden of verlopen!")),
      );
    }
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
              onPressed: generateSyncCode,
              child: const Text("Genereer synchronisatiecode"),
            ),
            if (syncCode.isNotEmpty) Text("Jouw code: $syncCode"),
            const SizedBox(height: 20),
            TextField(controller: codeController, decoration: InputDecoration(labelText: "Voer synchronisatiecode in")),
            ElevatedButton(
              onPressed: syncData,
              child: const Text("Synchroniseren"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pallets.length,
                itemBuilder: (context, index) {
                  final pallet = pallets[index];
                  return ListTile(
                    title: Text("Pallet ${pallet['ID']}: ${pallet['Breedte']} x ${pallet['Hoogte']} x ${pallet['Lengte']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
