import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  final List<Map<String, dynamic>> pallets = [
    {"id": 1, "type": "Normaal", "gewicht": 500},
    {"id": 2, "type": "Gevaarlijk (Brandbaar)", "gewicht": 600},
    {"id": 3, "type": "Gevaarlijk (Chemisch)", "gewicht": 700},
  ];

  String checkRules() {
    for (var i = 0; i < pallets.length - 1; i++) {
      if (pallets[i]["type"].contains("Gevaarlijk") && pallets[i + 1]["type"].contains("Gevaarlijk")) {
        return "Waarschuwing: Gevaarlijke pallets mogen niet naast elkaar staan!";
      }
    }
    return "Configuratie is geldig.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laadvoorschriften")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pallets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Pallet ${pallets[index]["id"]}: ${pallets[index]["type"]}"),
                    subtitle: Text("Gewicht: ${pallets[index]["gewicht"]} kg"),
                  );
                },
              ),
            ),
            Text(
              checkRules(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
