import 'package:flutter/material.dart';

class PaymentCardBrandMark extends StatelessWidget {
  const PaymentCardBrandMark({super.key, required this.isMastercard});

  final bool isMastercard;

  @override
  Widget build(BuildContext context) {
    if (!isMastercard) {
      return Text(
        'VISA',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w900,
          color: const Color(0xFF1A1F71),
          fontStyle: FontStyle.italic,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFFEB001B),
            shape: BoxShape.circle,
          ),
        ),
        Transform.translate(
          offset: const Offset(-7, 0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
