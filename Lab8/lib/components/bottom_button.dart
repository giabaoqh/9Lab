import 'package:flutter/material.dart';
import '../constants.dart';

/// Component BottomButton - nút bấm lớn tràn viền nằm dưới cùng màn hình.
/// Sử dụng màu hồng đỏ đặc trưng (`#EB1555`) để kích hoạt tính toán hoặc chuyển trang.
class BottomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;

  const BottomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kBottomContainerColor,
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: kBottomContainerHeight,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
