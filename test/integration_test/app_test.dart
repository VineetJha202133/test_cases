import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_geeksynergy_task/main.dart';  // Adjust the import based on your main file location.

void main() {
  group('App Integration Test', () {
    testWidgets('Register, Login, and Home screen flow', (tester) async {
      await tester.pumpWidget(MyApp());

      // Navigate to Register Screen
      expect(find.text('Signup'), findsOneWidget);
      await tester.tap(find.text('Signup'));
      await tester.pumpAndSettle();

      // Fill out the registration form
      await tester.enterText(find.byKey(Key('nameField')), 'John Doe');
      await tester.enterText(find.byKey(Key('emailField')), 'john.doe@example.com');
      await tester.enterText(find.byKey(Key('phoneField')), '1234567890');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('professionField')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Developer').last); // Select 'Developer'
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('signupButton')));
      await tester.pumpAndSettle();

      // Ensure registration success and navigate to Home Screen
      expect(find.text('Registration Successful'), findsOneWidget);
      await tester.tap(find.byKey(Key('goToLoginButton')));
      await tester.pumpAndSettle();

      // Login with registered credentials
      await tester.enterText(find.byKey(Key('loginNameField')), 'John Doe');
      await tester.enterText(find.byKey(Key('loginPasswordField')), 'password123');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      // Verify Home Screen is displayed
      expect(find.text('Movies'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Interact with Home Screen
      await tester.drag(find.byType(ListView), const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Open the company info dialog
      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();
      expect(find.text('Company Info'), findsOneWidget);

      // Close the dialog
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });
  });
}
