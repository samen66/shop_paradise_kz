import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

Future<void> shareShoppingNotesCsv(String csv) async {
  await SharePlus.instance.share(
    ShareParams(text: csv, subject: 'Shopping notes'),
  );
}

Future<void> shareShoppingNotesPdf(Uint8List bytes) async {
  await SharePlus.instance.share(
    ShareParams(
      text:
          'PDF export is available in the mobile and desktop app builds.',
      subject: 'Shopping notes',
    ),
  );
}
