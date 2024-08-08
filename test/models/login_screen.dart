import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/controller/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginController Tests', () {
    late LoginController loginController;

    setUp(() {
      loginController = LoginController();
    });

    test('Initial values should be null', () {
      expect(loginController.name, isNull);
      expect(loginController.password, isNull);
    });

    test('Form validation should return true when all fields are valid', () {
      final formKey = GlobalKey<FormState>();
      loginController = LoginController();

      final form = Form(
        key: formKey,
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                TextFormField(
                  initialValue: 'John Doe',
                  onSaved: (value) => loginController.name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: 'password123',
                  onSaved: (value) => loginController.password = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ],
            );
          },
        ),
      );

      formKey.currentState?.save();
      expect(formKey.currentState?.validate(), true);
    });

    test('Login should succeed with correct credentials', () async {
      SharedPreferences.setMockInitialValues({
        'name': 'John Doe',
        'password': 'password123',
      });
      final prefs = await SharedPreferences.getInstance();

      loginController.name = 'John Doe';
      loginController.password = 'password123';

      // Mocking the login method
      bool snackBarShown = false;
      loginController.login(MockBuildContext(
        onShowSnackBar: (snackBar) {
          snackBarShown = true;
        },
      ));

      expect(loginController.name, 'John Doe');
      expect(loginController.password, 'password123');
      expect(prefs.getString('name'), 'John Doe');
      expect(prefs.getString('password'), 'password123');
      expect(snackBarShown, false);
    });

    test('Login should fail with incorrect credentials', () async {
      SharedPreferences.setMockInitialValues({
        'name': 'John Doe',
        'password': 'password123',
      });

      loginController.name = 'Jane Doe';
      loginController.password = 'wrongpassword';

      bool snackBarShown = false;
      MockBuildContext context = MockBuildContext(
        onShowSnackBar: (snackBar) {
          snackBarShown = true;
          expect(snackBar.content.toString(), contains('Invalid Credentials'));
        },
      );

      loginController.login(context);

      expect(snackBarShown, true);
    });
  });
}

// Mock BuildContext for testing without an actual UI
class MockBuildContext extends BuildContext {
  final Function(SnackBar) onShowSnackBar;

  MockBuildContext({required this.onShowSnackBar});

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #showSnackBar) {
      onShowSnackBar(invocation.positionalArguments[0] as SnackBar);
    }
    return super.noSuchMethod(invocation);
  }
}
