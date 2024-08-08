import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/controller/login_controller.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/screens/login_screen.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/screens/register_screen.dart';

Widget createLoginScreen() => ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Testing if "Welcome Back" text is present', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('Testing if Login form fields are present', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('Testing form validation - Empty Name', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.enterText(find.byType(TextFormField).first, '');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Please enter your name'), findsOneWidget);
    });

    testWidgets('Testing form validation - Empty Password', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.enterText(find.byType(TextFormField).last, '');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('Testing Navigation to Signup Screen', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.tap(find.text('Signup'));
      await tester.pumpAndSettle();
      expect(find.byType(SignupScreen), findsOneWidget);
    });

    testWidgets('Testing successful form submission', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.enterText(find.byType(TextFormField).first, 'John Doe');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
    });
  });
}
