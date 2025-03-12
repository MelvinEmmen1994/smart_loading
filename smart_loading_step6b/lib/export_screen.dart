import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final List<Map<String, String>> pallets = [];
  final TextEditingController idController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();

  void addPallet() {
    setState(() {
      pallets.add({
        "ID": idController.text,
        "Breedte": widthController.text,
        "Hoogte": heightController.text,
        "Lengte": lengthController.text,
      });
      idController.clear();
      widthController.clear();
      heightController.clear();
      lengthController.clear();
    });
  }

  Future<void> exportToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("Laadconfiguratie", style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              for (var pallet in pallets)
                pw.Text("Pallet ${pallet['ID']}: ${pallet['Breedte']} x ${pallet['Hoogte']} x ${pallet['Lengte']}"),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("\${output.path}/laadconfiguratie.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(bytes: await pdf.save(), filename: "laadconfiguratie.pdf");
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    var sheet = excel['Laadconfiguratie'];

    sheet.appendRow(["Pallet ID", "Breedte", "Hoogte", "Lengte"]);
    for (var pallet in pallets) {
      sheet.appendRow([pallet['ID'], pallet['Breedte'], pallet['Hoogte'], pallet['Lengte']]);
    }

    final output = await getTemporaryDirectory();
    final file = File("\${output.path}/laadconfiguratie.xlsx");
    await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Excel-bestand opgeslagen in \${output.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Afwijkende Palletmaten")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: "Pallet ID")),
            TextField(controller: widthController, decoration: InputDecoration(labelText: "Breedte (cm)")),
            TextField(controller: heightController, decoration: InputDecoration(labelText: "Hoogte (cm)")),
            TextField(controller: lengthController, decoration: InputDecoration(labelText: "Lengte (cm)")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: addPallet, child: const Text("Pallet toevoegen")),
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
            const SizedBox(height: 20),
            ElevatedButton(onPressed: exportToPDF, child: const Text("Exporteren naar PDF")),
            ElevatedButton(onPressed: exportToExcel, child: const Text("Exporteren naar Excel")),
          ],
        ),
      ),
    );
  }
}
