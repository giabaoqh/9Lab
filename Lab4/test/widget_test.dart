import 'package:flutter_test/flutter_test.dart';
import 'package:magic_8_ball/main.dart';

void main() {
  testWidgets('Magic 8 Ball app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BallPage());
  });
}
