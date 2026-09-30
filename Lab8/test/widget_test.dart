import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('BMI Calculator smoke test', (WidgetTester tester) async {
    // Đặt kích thước màn hình test chuẩn Phone (414 x 896 pt)
    tester.view.physicalSize = const Size(1080, 2280);
    tester.view.devicePixelRatio = 2.0;

    // Khôi phục kích thước màn hình sau khi hoàn thành test
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Xây dựng app và kích hoạt frame đầu tiên
    await tester.pumpWidget(const BMICalculator());

    // Kiểm tra AppBar hiển thị tiêu đề 'BMI CALCULATOR'
    expect(find.text('BMI CALCULATOR'), findsWidgets);
  });
}
