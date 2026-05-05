/// Feature-first layout: implementation lives under [lib/features/].
/// This library exposes the shopping_notes **data** layer at a root
/// `lib/data/` path for reviewers who expect layer folders at the project
/// root (reference vertical slice only).
library;

export 'package:shop_paradise_kz/features/shopping_notes/data/drift/shopping_notes_database.dart';
export 'package:shop_paradise_kz/features/shopping_notes/data/notes_remote_data_source.dart';
export 'package:shop_paradise_kz/features/shopping_notes/data/shopping_notes_repository_impl.dart';
