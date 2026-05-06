class AiService {
  const AiService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emojiIcon,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final String emojiIcon;
  final bool isSelected;

  AiService copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    String? emojiIcon,
    bool? isSelected,
  }) {
    return AiService(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      emojiIcon: emojiIcon ?? this.emojiIcon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

