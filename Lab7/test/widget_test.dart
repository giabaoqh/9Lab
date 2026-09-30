import 'package:flutter_test/flutter_test.dart';
import 'package:destini/main.dart';

void main() {
  testWidgets('Destini app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DestiniApp());
    expect(find.byType(DestiniApp), findsOneWidget);
  });
}
