import 'package:flutter_test/flutter_test.dart';
import 'package:xylophone/main.dart';

void main() {
  testWidgets('Xylophone app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const XylophoneApp());

    // Verify that the Xylophone keys are rendered.
    expect(find.text('C - Đô'), findsOneWidget);
    expect(find.text('B - Xì'), findsOneWidget);
  });
}
