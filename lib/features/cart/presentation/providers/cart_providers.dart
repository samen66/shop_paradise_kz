import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_cart_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/apply_promo_code_use_case.dart';
import '../../domain/usecases/clear_promo_use_case.dart';
import '../../domain/usecases/dismiss_cart_banner_use_case.dart';
import '../../domain/usecases/get_cart_use_case.dart';
import '../../domain/usecases/remove_cart_line_use_case.dart';
import '../../domain/usecases/remove_selected_cart_lines_use_case.dart';
import '../../domain/usecases/set_cart_line_selected_use_case.dart';
import '../../domain/usecases/set_cart_selection_mode_use_case.dart';
import '../../domain/usecases/set_promo_expanded_use_case.dart';
import '../../domain/usecases/update_line_quantity_use_case.dart';

final cartRepositoryProvider = Provider<CartRepository>(
  (Ref ref) => MockCartRepositoryImpl(),
);

final getCartUseCaseProvider = Provider<GetCartUseCase>(
  (Ref ref) => GetCartUseCase(ref.watch(cartRepositoryProvider)),
);

final updateLineQuantityUseCaseProvider = Provider<UpdateLineQuantityUseCase>(
  (Ref ref) => UpdateLineQuantityUseCase(ref.watch(cartRepositoryProvider)),
);

final removeCartLineUseCaseProvider = Provider<RemoveCartLineUseCase>(
  (Ref ref) => RemoveCartLineUseCase(ref.watch(cartRepositoryProvider)),
);

final applyPromoCodeUseCaseProvider = Provider<ApplyPromoCodeUseCase>(
  (Ref ref) => ApplyPromoCodeUseCase(ref.watch(cartRepositoryProvider)),
);

final clearPromoUseCaseProvider = Provider<ClearPromoUseCase>(
  (Ref ref) => ClearPromoUseCase(ref.watch(cartRepositoryProvider)),
);

final setCartSelectionModeUseCaseProvider =
    Provider<SetCartSelectionModeUseCase>(
      (Ref ref) =>
          SetCartSelectionModeUseCase(ref.watch(cartRepositoryProvider)),
    );

final setCartLineSelectedUseCaseProvider = Provider<SetCartLineSelectedUseCase>(
  (Ref ref) => SetCartLineSelectedUseCase(ref.watch(cartRepositoryProvider)),
);

final removeSelectedCartLinesUseCaseProvider =
    Provider<RemoveSelectedCartLinesUseCase>(
      (Ref ref) =>
          RemoveSelectedCartLinesUseCase(ref.watch(cartRepositoryProvider)),
    );

final setPromoExpandedUseCaseProvider = Provider<SetPromoExpandedUseCase>(
  (Ref ref) => SetPromoExpandedUseCase(ref.watch(cartRepositoryProvider)),
);

final dismissCartBannerUseCaseProvider = Provider<DismissCartBannerUseCase>(
  (Ref ref) => DismissCartBannerUseCase(ref.watch(cartRepositoryProvider)),
);
