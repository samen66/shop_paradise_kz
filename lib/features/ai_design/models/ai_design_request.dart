import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'supported_room_type.dart';
import 'supported_style.dart';

class AiDesignRequest {
  const AiDesignRequest({
    required this.photo,
    required this.style,
    required this.roomType,
    required this.budgetRange,
    required this.includeServices,
    required this.onlyInStock,
    required this.considerExistingFurniture,
  });

  final XFile photo;
  final SupportedStyle style;
  final SupportedRoomType roomType;
  final RangeValues budgetRange;
  final bool includeServices;
  final bool onlyInStock;
  final bool considerExistingFurniture;
}

