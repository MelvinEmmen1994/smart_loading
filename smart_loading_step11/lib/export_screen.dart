import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  Future<void> exportToPDF() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text("Laadconfiguratie Export", style: pw.TextStyle(fontSize: 24)),
      ),
    ));

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/laadconfiguratie.pdf");
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    var sheet = excel['Laadconfiguratie'];
    sheet.appendRow(["Palletnummer", "Breedte", "Hoogte", "Gewicht"]);
    sheet.appendRow(["1", "120 cm", "100 cm", "500 kg"]);
    sheet.appendRow(["2", "80 cm", "120 cm", "700 kg"]);

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/laadconfiguratie.xlsx");
    await file.writeAsBytes(excel.encode()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exporteren")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: exportToPDF,
              child: const Text("Exporteer als PDF"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: exportToExcel,
              child: const Text("Exporteer als Excel"),
            ),
          ],
        ),
      ),
    );
  }
}
