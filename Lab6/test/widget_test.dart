import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/main.dart';

void main() {
  testWidgets('Quizzler app loads properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Quizzler());

    // Verify that "Đúng" and "Sai" buttons exist.
    expect(find.text('Đúng'), findsOneWidget);
    expect(find.text('Sai'), findsOneWidget);
  });
}
