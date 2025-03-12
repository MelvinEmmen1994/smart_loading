import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:pdf/widgets.dart' as pdf;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final List<Map<String, dynamic>> pallets = [
    {"id": 1, "afmetingen": "120x80 cm", "gewicht": 500},
    {"id": 2, "afmetingen": "100x100 cm", "gewicht": 600},
  ];

  Future<void> _exportToExcel() async {
    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("Pallet ID");
    sheet.getRangeByName("B1").setText("Afmetingen");
    sheet.getRangeByName("C1").setText("Gewicht (kg)");

    for (int i = 0; i < pallets.length; i++) {
      sheet.getRangeByIndex(i + 2, 1).setNumber(pallets[i]["id"].toDouble());
      sheet.getRangeByIndex(i + 2, 2).setText(pallets[i]["afmetingen"]);
      sheet.getRangeByIndex(i + 2, 3).setNumber(pallets[i]["gewicht"].toDouble());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/Laadconfiguratie.xlsx");
    await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> _exportToPDF() async {
    final pdf.Document doc = pdf.Document();

    doc.addPage(pdf.Page(
      build: (context) => pdf.Table.fromTextArray(
        data: [
          ["Pallet ID", "Afmetingen", "Gewicht (kg)"],
          for (var pallet in pallets) [pallet["id"], pallet["afmetingen"], pallet["gewicht"]],
        ],
      ),
    ));

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/Laadconfiguratie.pdf");
    await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exporteren")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _exportToExcel,
              child: const Text("Exporteer als Excel"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _exportToPDF,
              child: const Text("Exporteer als PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
