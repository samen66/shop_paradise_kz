import 'dart:typed_data';

import 'shopping_notes_share_web.dart'
    if (dart.library.io) 'shopping_notes_share_io.dart' as share_impl;

Future<void> shareShoppingNotesCsv(String csv) =>
    share_impl.shareShoppingNotesCsv(csv);

Future<void> shareShoppingNotesPdf(Uint8List bytes) =>
    share_impl.shareShoppingNotesPdf(bytes);
