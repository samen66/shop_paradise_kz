enum SupportedStyle {
  any,
  modern,
  scandi,
  classic,
  loft,
  provence,
  minimalism,
  eclectic,
}

extension SupportedStyleX on SupportedStyle {
  String get label {
    return switch (this) {
      SupportedStyle.any => 'Любой',
      SupportedStyle.modern => 'Современный',
      SupportedStyle.scandi => 'Скандинавский',
      SupportedStyle.classic => 'Классический',
      SupportedStyle.loft => 'Лофт',
      SupportedStyle.provence => 'Прованс',
      SupportedStyle.minimalism => 'Минимализм',
      SupportedStyle.eclectic => 'Эклектика',
    };
  }

  String get emoji {
    return switch (this) {
      SupportedStyle.any => '🎯',
      SupportedStyle.modern => '🏙',
      SupportedStyle.scandi => '🌿',
      SupportedStyle.classic => '🏺',
      SupportedStyle.loft => '🖤',
      SupportedStyle.provence => '🌸',
      SupportedStyle.minimalism => '🏯',
      SupportedStyle.eclectic => '🎨',
    };
  }
}

