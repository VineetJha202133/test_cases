import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/controller/register_controller.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/screens/register_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget createRegisterScreen() => ChangeNotifierProvider<RegisterController>(
      create: (context) => RegisterController(),
      child: const MaterialApp(
        home: SignupScreen(),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Test if all form fields are present', (tester) async {
      await tester.pumpWidget(createRegisterScreen());

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.text('Signup'), findsOneWidget);
    });

    testWidgets('Test form validation and submission', (tester) async {
      await tester.pumpWidget(createRegisterScreen());

      // Enter text into the form fields
      await tester.enterText(find.byKey(const Key('nameField')), 'John Doe');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'password123');
      await tester.enterText(
          find.byKey(const Key('emailField')), 'john.doe@example.com');
      await tester.enterText(
          find.byKey(const Key('phoneField')), '1234567890');
      await tester.tap(find.text('Signup'));

      await tester.pump();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('name'), 'John Doe');
      expect(prefs.getString('password'), 'password123');
      expect(prefs.getString('email'), 'john.doe@example.com');
      expect(prefs.getString('phone'), '1234567890');
      expect(prefs.getString('profession'), 'Developer');
    });

    testWidgets('Test form validation with invalid inputs', (tester) async {
      await tester.pumpWidget(createRegisterScreen());

      await tester.tap(find.text('Signup'));
      await tester.pump();

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your phone number'), findsOneWidget);
    });

    testWidgets('Test form validation with invalid email', (tester) async {
      await tester.pumpWidget(createRegisterScreen());

      await tester.enterText(find.byKey(const Key('emailField')), 'invalidemail');
      await tester.tap(find.text('Signup'));
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });
  });
}
