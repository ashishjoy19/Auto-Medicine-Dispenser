import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doctor_portal/main.dart';

void main() {
  testWidgets('Authentication screen UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the email and password text fields are rendered.
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the register and login buttons are rendered.
    expect(find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
