/// Feature-first layout: implementation lives under [lib/features/].
/// This library exposes the shopping_notes **domain** layer at a root
/// `lib/domain/` path for reviewers who expect layer folders at the project
/// root (reference vertical slice only).
library;

export 'package:shop_paradise_kz/features/shopping_notes/domain/entities/shopping_note_entity.dart';
export 'package:shop_paradise_kz/features/shopping_notes/domain/entities/spending_category_entity.dart';
export 'package:shop_paradise_kz/features/shopping_notes/domain/repositories/shopping_notes_repository.dart';
