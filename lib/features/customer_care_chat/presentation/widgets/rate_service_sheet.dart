import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'chat_sheet_shell.dart';

class RateServiceSheet extends StatefulWidget {
  const RateServiceSheet({
    super.key,
    required this.title,
    required this.agentName,
    required this.subtitle,
    required this.commentHint,
    required this.nextLabel,
    required this.onSubmit,
    required this.onClose,
  });

  final String title;
  final String agentName;
  final String subtitle;
  final String commentHint;
  final String nextLabel;
  final void Function(int stars, String comment) onSubmit;
  final VoidCallback onClose;

  @override
  State<RateServiceSheet> createState() => _RateServiceSheetState();
}

class _RateServiceSheetState extends State<RateServiceSheet> {
  int _stars = 0;
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ChatSheetShell(
      title: widget.title,
      nextLabel: widget.nextLabel,
      nextEnabled: _stars > 0,
      onClose: widget.onClose,
      onNext: () {
        widget.onSubmit(_stars, _comment.text.trim());
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.blobLightBlue,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/maggy_agent/200/200',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.agentName,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(5, (int i) {
              final int starIndex = i + 1;
              final bool filled = starIndex <= _stars;
              return IconButton(
                onPressed: () {
                  setState(() {
                    _stars = starIndex;
                  });
                },
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: filled ? const Color(0xFFFFC107) : const Color(0xFFFFC107),
                  size: 36,
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _comment,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.commentHint,
              filled: true,
              fillColor: AppColors.blobLightBlue.withValues(alpha: 0.35),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
