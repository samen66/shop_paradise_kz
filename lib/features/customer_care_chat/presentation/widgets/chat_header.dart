import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/chat_models.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.kind,
    required this.chatBotTitle,
    required this.agentName,
    required this.subtitle,
  });

  final CustomerCareHeaderKind kind;
  final String chatBotTitle;
  final String agentName;
  final String subtitle;

  static const String _agentAvatarUrl =
      'https://picsum.photos/seed/maggy_agent/200/200';

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isBot = kind == CustomerCareHeaderKind.chatBot;
    final String title = isBot ? chatBotTitle : agentName;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: <Widget>[
          if (isBot)
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.blobLightBlue,
              child: Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
            )
          else
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.blobLightBlue,
              backgroundImage: const NetworkImage(_agentAvatarUrl),
              onBackgroundImageError: (_, __) {},
              child: const SizedBox.shrink(),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
