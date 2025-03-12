import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:excel/excel.dart';

class ExcelUpload extends StatefulWidget {
  const ExcelUpload({super.key});

  @override
  State<ExcelUpload> createState() => _ExcelUploadState();
}

class _ExcelUploadState extends State<ExcelUpload> {
  List<Map<String, dynamic>> palletData = [];

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      setState(() {
        palletData.clear();
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows.skip(1)) {
            palletData.add({
              'length': double.tryParse(row[0]?.value.toString() ?? '0') ?? 0,
              'width': double.tryParse(row[1]?.value.toString() ?? '0') ?? 0,
              'height': double.tryParse(row[2]?.value.toString() ?? '0') ?? 0,
              'weight': double.tryParse(row[3]?.value.toString() ?? '0') ?? 0,
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Excel-bestand')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickExcelFile,
              child: const Text('Selecteer Excel-bestand'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: palletData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Pallet ${index + 1}'),
                    subtitle: Text(
                      'L: ${palletData[index]['length']} cm, '
                      'B: ${palletData[index]['width']} cm, '
                      'H: ${palletData[index]['height']} cm, '
                      'Gewicht: ${palletData[index]['weight']} kg',
                    ),
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
