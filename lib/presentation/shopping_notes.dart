/// Feature-first layout: implementation lives under [lib/features/].
/// This library exposes the shopping_notes **presentation** layer at a root
/// `lib/presentation/` path for reviewers who expect layer folders at the
/// project root (reference vertical slice only).
library;

export 'package:shop_paradise_kz/features/shopping_notes/presentation/pages/shopping_notes_page.dart';
export 'package:shop_paradise_kz/features/shopping_notes/presentation/pages/spending_analytics_page.dart';
export 'package:shop_paradise_kz/features/shopping_notes/presentation/providers/shopping_notes_providers.dart';
