import 'package:intl/intl.dart';

import '../entities/shopping_note_entity.dart';

/// Builds RFC4180-style CSV for shopping notes (UTF-8).
class BuildShoppingNotesCsvUseCase {
  const BuildShoppingNotesCsvUseCase();

  static final DateFormat _iso = DateFormat('yyyy-MM-ddTHH:mm:ss');

  String call(
    List<ShoppingNoteEntity> notes, {
    required List<String> columnHeaders,
  }) {
    final StringBuffer buf = StringBuffer();
    buf.writeln(columnHeaders.map(_escapeCell).join(','));
    for (final ShoppingNoteEntity n in notes) {
      final List<String> row = <String>[
        n.id.toString(),
        n.title,
        n.body,
        n.category,
        n.categoryId?.toString() ?? '',
        n.amount.toString(),
        n.syncedToRemote.toString(),
        _iso.format(n.createdAt.toUtc()),
        _iso.format(n.updatedAt.toUtc()),
      ];
      buf.writeln(row.map(_escapeCell).join(','));
    }
    return buf.toString();
  }

  String _escapeCell(String raw) {
    final bool needsQuotes =
        raw.contains(',') ||
        raw.contains('"') ||
        raw.contains('\n') ||
        raw.contains('\r');
    String s = raw.replaceAll('"', '""');
    if (needsQuotes) {
      s = '"$s"';
    }
    return s;
  }
}
