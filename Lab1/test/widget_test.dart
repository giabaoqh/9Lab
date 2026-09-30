import 'package:flutter_test/flutter_test.dart';
import 'package:i_am_rich/main.dart';

void main() {
  testWidgets('I Am Rich smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const IAmRichApp());

    // Verify that the title 'I Am Rich' is displayed.
    expect(find.text('I Am Rich'), findsOneWidget);
  });
}
