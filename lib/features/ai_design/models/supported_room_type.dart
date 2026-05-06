enum SupportedRoomType {
  livingRoom,
  bedroom,
  kitchen,
  bathroom,
  office,
  kids,
}

extension SupportedRoomTypeX on SupportedRoomType {
  String get label {
    return switch (this) {
      SupportedRoomType.livingRoom => 'Гостиная',
      SupportedRoomType.bedroom => 'Спальня',
      SupportedRoomType.kitchen => 'Кухня',
      SupportedRoomType.bathroom => 'Ванная',
      SupportedRoomType.office => 'Кабинет',
      SupportedRoomType.kids => 'Детская',
    };
  }

  String get emoji {
    return switch (this) {
      SupportedRoomType.livingRoom => '🛋',
      SupportedRoomType.bedroom => '🛏',
      SupportedRoomType.kitchen => '🍳',
      SupportedRoomType.bathroom => '🛁',
      SupportedRoomType.office => '📚',
      SupportedRoomType.kids => '🧒',
    };
  }
}

