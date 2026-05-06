import 'package:flutter/material.dart';

class BeforeAfterSlider extends StatefulWidget {
  const BeforeAfterSlider({
    super.key,
    required this.before,
    required this.after,
    this.initialFraction = 0.5,
  });

  final Widget before;
  final Widget after;
  final double initialFraction;

  @override
  State<BeforeAfterSlider> createState() => _BeforeAfterSliderState();
}

class _BeforeAfterSliderState extends State<BeforeAfterSlider> {
  late double _fraction;

  @override
  void initState() {
    super.initState();
    _fraction = widget.initialFraction.clamp(0.05, 0.95);
  }

  void _updateFraction(Offset localPosition, double width) {
    final double next = (localPosition.dx / width).clamp(0.05, 0.95);
    setState(() => _fraction = next);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double dividerX = width * _fraction;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (DragDownDetails details) {
            _updateFraction(details.localPosition, width);
          },
          onPanUpdate: (DragUpdateDetails details) {
            _updateFraction(details.localPosition, width);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: widget.before),
                Positioned.fill(
                  child: ClipRect(
                    clipper: _FractionClipper(fraction: _fraction),
                    child: widget.after,
                  ),
                ),
                Positioned(
                  left: dividerX - 1,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 2, color: Colors.white.withValues(alpha: 0.9)),
                ),
                Positioned(
                  left: dividerX - 18,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black.withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.compare_arrows_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 12,
                  top: 12,
                  child: _CornerLabel(text: 'До'),
                ),
                const Positioned(
                  right: 12,
                  top: 12,
                  child: _CornerLabel(text: 'После'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FractionClipper extends CustomClipper<Rect> {
  const _FractionClipper({required this.fraction});

  final double fraction;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(_FractionClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}

class _CornerLabel extends StatelessWidget {
  const _CornerLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

