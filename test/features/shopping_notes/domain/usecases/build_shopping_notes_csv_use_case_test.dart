import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/entities/shopping_note_entity.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/usecases/build_shopping_notes_csv_use_case.dart';

void main() {
  const BuildShoppingNotesCsvUseCase useCase = BuildShoppingNotesCsvUseCase();
  const List<String> headers = <String>[
    'id',
    'title',
    'body',
    'category',
    'category_id',
    'amount',
    'synced_to_remote',
    'created_at_utc',
    'updated_at_utc',
  ];

  ShoppingNoteEntity note({
    required int id,
    required String title,
    required String body,
    String category = 'c',
    int? categoryId = 1,
    double amount = 1,
    bool synced = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final DateTime t = createdAt ?? DateTime.utc(2026, 1, 2, 3, 4, 5);
    return ShoppingNoteEntity(
      id: id,
      title: title,
      body: body,
      category: category,
      categoryId: categoryId,
      amount: amount,
      syncedToRemote: synced,
      createdAt: t,
      updatedAt: updatedAt ?? t,
    );
  }

  test('empty list yields header row only', () {
    final String actual = useCase.call(<ShoppingNoteEntity>[], columnHeaders: headers);
    expect(actual.trim(), headers.join(','));
  });

  test('single row formats amount and booleans', () {
    final String actual = useCase.call(
      <ShoppingNoteEntity>[
        note(id: 1, title: 'A', body: 'B', amount: 3.5, synced: true),
      ],
      columnHeaders: headers,
    );
    final List<String> lines = actual.trim().split('\n');
    expect(lines.length, 2);
    expect(
      lines[1],
      '1,A,B,c,1,3.5,true,2026-01-02T03:04:05,2026-01-02T03:04:05',
    );
  });

  test('escapes commas quotes and newlines in fields', () {
    final String actual = useCase.call(
      <ShoppingNoteEntity>[
        note(
          id: 2,
          title: 'a,b',
          body: 'say "hi"',
        ),
      ],
      columnHeaders: headers,
    );
    final List<String> lines = actual.trim().split('\n');
    expect(
      lines[1],
      '2,"a,b","say ""hi""",c,1,1.0,false,2026-01-02T03:04:05,'
      '2026-01-02T03:04:05',
    );
  });
}
