import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_orders_repository_impl.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/usecases/get_orders_use_case.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>(
  (Ref ref) => MockOrdersRepositoryImpl(),
);

final getOrdersUseCaseProvider = Provider<GetOrdersUseCase>(
  (Ref ref) => GetOrdersUseCase(ref.watch(ordersRepositoryProvider)),
);
