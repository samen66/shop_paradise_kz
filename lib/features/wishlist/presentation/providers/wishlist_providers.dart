import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_wishlist_repository_impl.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../domain/usecases/get_wishlist_items_use_case.dart';

final wishlistRepositoryProvider = Provider<WishlistRepository>(
  (Ref ref) => const MockWishlistRepositoryImpl(),
);

final getWishlistItemsUseCaseProvider = Provider<GetWishlistItemsUseCase>(
  (Ref ref) => GetWishlistItemsUseCase(ref.watch(wishlistRepositoryProvider)),
);
