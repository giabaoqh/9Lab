import 'package:flutter/material.dart';

/// Component RoundIconButton - nút bấm hình tròn tùy chỉnh 44x44.
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(
        width: 44.0,
        height: 44.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.0,
      ),
    );
  }
}
