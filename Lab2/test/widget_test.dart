import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:micard/main.dart';

void main() {
  testWidgets('MiCard renders key contact info', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiCardApp());

    // Verify that our name and role are rendered.
    expect(find.text('ThinkPad E14'), findsOneWidget);
    expect(find.text('FLUTTER DEVELOPER'), findsOneWidget);

    // Verify phone & email contact items exist
    expect(find.text('+84 394 281 107'), findsOneWidget);
    expect(find.text('flutter.developer@gmail.com'), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
  });
}
