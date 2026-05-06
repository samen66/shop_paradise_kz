import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

import '../entities/shopping_note_entity.dart';

/// Builds a simple tabular PDF for shopping notes.
class BuildShoppingNotesPdfBytesUseCase {
  const BuildShoppingNotesPdfBytesUseCase();

  Future<Uint8List> call(
    List<ShoppingNoteEntity> notes, {
    required String documentTitle,
    required List<String> columnHeaders,
  }) async {
    final pw.Document doc = pw.Document();
    final List<List<String>> rows = notes
        .map(
          (ShoppingNoteEntity n) => <String>[
            n.id.toString(),
            n.title,
            n.category,
            n.amount.toStringAsFixed(2),
          ],
        )
        .toList();
    doc.addPage(
      pw.MultiPage(
        build: (pw.Context ctx) => <pw.Widget>[
          pw.Text(documentTitle, style: pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: columnHeaders,
            data: rows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
          ),
        ],
      ),
    );
    return doc.save();
  }
}
