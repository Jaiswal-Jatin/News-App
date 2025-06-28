// This is a basic Flutter widget test for NewsFlow app.

import 'package:flutter_test/flutter_test.dart';
import 'package:newsflow_app/main.dart';

void main() {
  testWidgets('NewsFlow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is present
    expect(find.text('NewsFlow'), findsOneWidget);
  });
}
