import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/mock_data.dart';
import '../models/ai_design_request.dart';
import '../models/ai_design_result.dart';
import '../models/ai_service.dart';
import '../models/product_recommendation.dart';
import '../models/supported_room_type.dart';
import '../models/supported_style.dart';

enum AnalysisStatus { idle, loading, success, error }

class AiDesignState {
  const AiDesignState({
    required this.status,
    required this.photo,
    required this.style,
    required this.roomType,
    required this.budgetRange,
    required this.includeServices,
    required this.onlyInStock,
    required this.considerExistingFurniture,
    required this.products,
    required this.services,
    required this.result,
    required this.history,
    required this.errorMessage,
  });

  factory AiDesignState.initial() {
    return AiDesignState(
      status: AnalysisStatus.idle,
      photo: null,
      style: SupportedStyle.any,
      roomType: SupportedRoomType.livingRoom,
      budgetRange: const RangeValues(150000, 500000),
      includeServices: true,
      onlyInStock: true,
      considerExistingFurniture: false,
      products: const <ProductRecommendation>[],
      services: buildMockServices(),
      result: null,
      history: const <AiDesignResult>[],
      errorMessage: null,
    );
  }

  final AnalysisStatus status;
  final XFile? photo;
  final SupportedStyle style;
  final SupportedRoomType roomType;
  final RangeValues budgetRange;
  final bool includeServices;
  final bool onlyInStock;
  final bool considerExistingFurniture;
  final List<ProductRecommendation> products;
  final List<AiService> services;
  final AiDesignResult? result;
  final List<AiDesignResult> history;
  final String? errorMessage;

  int get totalItems {
    return products.fold<int>(0, (int sum, ProductRecommendation p) {
      if (!p.isInCart) {
        return sum;
      }
      return sum + p.quantity;
    });
  }

  int get productsTotal {
    return products.fold<int>(0, (int sum, ProductRecommendation p) {
      if (!p.isInCart) {
        return sum;
      }
      return sum + p.total;
    });
  }

  int get servicesTotal {
    if (!includeServices) {
      return 0;
    }
    return services.fold<int>(0, (int sum, AiService s) {
      if (!s.isSelected) {
        return sum;
      }
      return sum + s.price;
    });
  }

  int get grandTotal => productsTotal + servicesTotal;

  AiDesignRequest? get request {
    final XFile? p = photo;
    if (p == null) {
      return null;
    }
    return AiDesignRequest(
      photo: p,
      style: style,
      roomType: roomType,
      budgetRange: budgetRange,
      includeServices: includeServices,
      onlyInStock: onlyInStock,
      considerExistingFurniture: considerExistingFurniture,
    );
  }

  AiDesignState copyWith({
    AnalysisStatus? status,
    XFile? photo,
    bool photoToNull = false,
    SupportedStyle? style,
    SupportedRoomType? roomType,
    RangeValues? budgetRange,
    bool? includeServices,
    bool? onlyInStock,
    bool? considerExistingFurniture,
    List<ProductRecommendation>? products,
    List<AiService>? services,
    AiDesignResult? result,
    bool resultToNull = false,
    List<AiDesignResult>? history,
    String? errorMessage,
    bool errorMessageToNull = false,
  }) {
    return AiDesignState(
      status: status ?? this.status,
      photo: photoToNull ? null : (photo ?? this.photo),
      style: style ?? this.style,
      roomType: roomType ?? this.roomType,
      budgetRange: budgetRange ?? this.budgetRange,
      includeServices: includeServices ?? this.includeServices,
      onlyInStock: onlyInStock ?? this.onlyInStock,
      considerExistingFurniture:
          considerExistingFurniture ?? this.considerExistingFurniture,
      products: products ?? this.products,
      services: services ?? this.services,
      result: resultToNull ? null : (result ?? this.result),
      history: history ?? this.history,
      errorMessage:
          errorMessageToNull ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final NotifierProvider<AiDesignNotifier, AiDesignState> aiDesignProvider =
    NotifierProvider<AiDesignNotifier, AiDesignState>(AiDesignNotifier.new);

class AiDesignNotifier extends Notifier<AiDesignState> {
  @override
  AiDesignState build() => AiDesignState.initial();

  void setPhoto(XFile photo) {
    state = state.copyWith(photo: photo, errorMessageToNull: true);
  }

  void clearPhoto() {
    state = state.copyWith(photoToNull: true, errorMessageToNull: true);
  }

  void setStyle(SupportedStyle style) {
    state = state.copyWith(style: style);
  }

  void setRoomType(SupportedRoomType roomType) {
    state = state.copyWith(roomType: roomType);
  }

  void setBudgetRange(RangeValues range) {
    state = state.copyWith(budgetRange: range);
  }

  void setIncludeServices(bool value) {
    state = state.copyWith(includeServices: value);
  }

  void setOnlyInStock(bool value) {
    state = state.copyWith(onlyInStock: value);
  }

  void setConsiderExistingFurniture(bool value) {
    state = state.copyWith(considerExistingFurniture: value);
  }

  void toggleProductInCart(String productId) {
    state = state.copyWith(
      products: state.products.map((ProductRecommendation p) {
        if (p.id != productId) {
          return p;
        }
        return p.copyWith(isInCart: !p.isInCart);
      }).toList(growable: false),
    );
  }

  void updateProductQuantity(String productId, int quantity) {
    final int clamped = quantity.clamp(1, 99);
    state = state.copyWith(
      products: state.products.map((ProductRecommendation p) {
        if (p.id != productId) {
          return p;
        }
        return p.copyWith(quantity: clamped);
      }).toList(growable: false),
    );
  }

  void addAllToCart() {
    state = state.copyWith(
      products: state.products
          .map((ProductRecommendation p) => p.copyWith(isInCart: true))
          .toList(growable: false),
    );
  }

  void toggleService(String serviceId) {
    state = state.copyWith(
      services: state.services.map((AiService s) {
        if (s.id != serviceId) {
          return s;
        }
        return s.copyWith(isSelected: !s.isSelected);
      }).toList(growable: false),
    );
  }

  Future<void> startAnalysis() async {
    final AiDesignRequest? req = state.request;
    if (req == null) {
      state = state.copyWith(
        status: AnalysisStatus.error,
        errorMessage: 'Сначала выберите фото комнаты.',
      );
      return;
    }

    state = state.copyWith(
      status: AnalysisStatus.loading,
      errorMessageToNull: true,
      resultToNull: true,
    );

    final List<ProductRecommendation> mockProducts = buildMockProducts();
    final List<String> afterVariants = <String>[
      'docs/screenshots/01_welcome.png',
      'docs/screenshots/02_shopping_notes.png',
      'docs/screenshots/03_spending_analytics.png',
    ];
    final String after =
        afterVariants[DateTime.now().millisecondsSinceEpoch % afterVariants.length];

    await Future<void>.delayed(const Duration(seconds: 5));

    final AiDesignResult result = buildMockResult(
      afterImageAssetPath: after,
      products: mockProducts,
    );

    state = state.copyWith(
      status: AnalysisStatus.success,
      products: mockProducts,
      result: result,
      history: <AiDesignResult>[result, ...state.history],
    );
  }
}

