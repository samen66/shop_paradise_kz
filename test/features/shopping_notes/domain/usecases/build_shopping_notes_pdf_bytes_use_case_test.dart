import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/entities/shopping_note_entity.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/usecases/build_shopping_notes_pdf_bytes_use_case.dart';

void main() {
  test('produces non-empty PDF bytes with signature', () async {
    const BuildShoppingNotesPdfBytesUseCase useCase =
        BuildShoppingNotesPdfBytesUseCase();
    final List<ShoppingNoteEntity> notes = <ShoppingNoteEntity>[
      ShoppingNoteEntity(
        id: 1,
        title: 'Milk',
        body: 'x',
        category: 'Food',
        categoryId: 1,
        amount: 2.5,
        syncedToRemote: false,
        createdAt: DateTime.utc(2026, 5, 1),
        updatedAt: DateTime.utc(2026, 5, 1),
      ),
    ];
    final Uint8List bytes = await useCase.call(
      notes,
      documentTitle: 'Notes',
      columnHeaders: <String>['ID', 'Title', 'Category', 'Amount'],
    );
    expect(bytes.isNotEmpty, isTrue);
    expect(ascii.decode(bytes.sublist(0, 4)), '%PDF');
  });
}
