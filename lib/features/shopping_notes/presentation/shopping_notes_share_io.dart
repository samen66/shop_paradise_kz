import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareShoppingNotesCsv(String csv) async {
  final Directory dir = await getTemporaryDirectory();
  final String fullPath = p.join(dir.path, 'shopping_notes.csv');
  final File file = File(fullPath);
  await file.writeAsString(csv);
  await SharePlus.instance.share(
    ShareParams(
      files: <XFile>[XFile(fullPath, mimeType: 'text/csv')],
      subject: 'Shopping notes',
    ),
  );
}

Future<void> shareShoppingNotesPdf(Uint8List bytes) async {
  final Directory dir = await getTemporaryDirectory();
  final String fullPath = p.join(dir.path, 'shopping_notes.pdf');
  final File file = File(fullPath);
  await file.writeAsBytes(bytes);
  await SharePlus.instance.share(
    ShareParams(
      files: <XFile>[XFile(fullPath, mimeType: 'application/pdf')],
      subject: 'Shopping notes',
    ),
  );
}
