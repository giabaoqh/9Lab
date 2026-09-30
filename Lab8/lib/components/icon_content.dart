import 'package:flutter/material.dart';
import '../constants.dart';

/// Component IconContent - hiển thị Biểu tượng và Nhãn chữ linh hoạt.
class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconContent({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 60.0,
          color: Colors.white,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
