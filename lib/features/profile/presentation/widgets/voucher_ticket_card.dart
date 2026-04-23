import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import 'voucher_visuals.dart';

int _calendarDaysUntil(DateTime end) {
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime endDay = DateTime(end.year, end.month, end.day);
  return endDay.difference(today).inDays;
}

class VoucherTicketCard extends StatelessWidget {
  const VoucherTicketCard({
    super.key,
    required this.voucher,
    this.collectLabel,
    this.onCollectPressed,
  });

  final VoucherEntity voucher;

  /// When set with [onCollectPressed], shows an outlined collect action instead
  /// of the default filled “Collected” control.
  final String? collectLabel;
  final VoidCallback? onCollectPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int daysLeft = _calendarDaysUntil(voucher.validUntil);
    final bool urgent =
        daysLeft >= 0 && daysLeft <= voucher.expiringWithinDays;
    final Color borderColor =
        urgent ? const Color(0xFFE57373) : AppColors.primary;
    final Color accent =
        urgent ? const Color(0xFFD32F2F) : AppColors.primary;
    final String validLabel = DateFormat('M.d.yy').format(voucher.validUntil);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: theme.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Voucher',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        if (urgent && daysLeft >= 0)
                          Text(
                            '$daysLeft days left',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: accent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        Text(
                          'Valid Until $validLabel',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: urgent
                                ? accent
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight:
                                urgent ? FontWeight.w800 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                return CustomPaint(
                  size: Size(c.maxWidth, 1),
                  painter: _DashedLinePainter(
                    color: borderColor.withValues(alpha: 0.5),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    voucherKindIcon(voucher.kind),
                    color: AppColors.primary,
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          voucher.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          voucher.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (onCollectPressed != null)
                    OutlinedButton(
                      onPressed: onCollectPressed,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(collectLabel ?? 'Collect'),
                    )
                  else
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Collected'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 4;
    const double dashSpace = 3;
    double startX = 0;
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), p);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
