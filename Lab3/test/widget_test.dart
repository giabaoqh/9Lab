import 'package:flutter_test/flutter_test.dart';
import 'package:dice_app/main.dart';

void main() {
  testWidgets('DiceApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DiceApp());

    // Verify that the AppBar title 'Dice' is present.
    expect(find.text('Dice'), findsOneWidget);

    // Verify that the Roll button is present.
    expect(find.text('LẮC XÚC XẮC'), findsOneWidget);
  });
}
