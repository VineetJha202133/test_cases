import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/controller/register_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterController Tests', () {
    late RegisterController registerController;

    setUp(() {
      registerController = RegisterController();
    });

    test('Initial values should be null', () {
      expect(registerController.name, isNull);
      expect(registerController.password, isNull);
      expect(registerController.email, isNull);
      expect(registerController.phone, isNull);
      expect(registerController.profession, isNull);
    });

    test('Form validation should return true when all fields are valid', () {
      final formKey = GlobalKey<FormState>();
      registerController = RegisterController();

      final form = Form(
        key: formKey,
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                TextFormField(
                  initialValue: 'John Doe',
                  onSaved: (value) => registerController.name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: 'password123',
                  onSaved: (value) => registerController.password = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: 'john.doe@example.com',
                  onSaved: (value) => registerController.email = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: '1234567890',
                  onSaved: (value) => registerController.phone = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: 'Developer',
                  items: ['Developer', 'Designer', 'Manager']
                      .map((profession) => DropdownMenuItem(
                            child: Text(profession),
                            value: profession,
                          ))
                      .toList(),
                  onChanged: (value) => registerController.profession = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your profession';
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

    test('SharedPreferences should store user data after signup', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      registerController.name = 'John Doe';
      registerController.password = 'password123';
      registerController.email = 'john.doe@example.com';
      registerController.phone = '1234567890';
      registerController.profession = 'Developer';

      
      registerController.signup(MockBuildContext());

      expect(prefs.getString('name'), 'John Doe');
      expect(prefs.getString('password'), 'password123');
      expect(prefs.getString('email'), 'john.doe@example.com');
      expect(prefs.getString('phone'), '1234567890');
      expect(prefs.getString('profession'), 'Developer');
    });
  });
}

// Mock BuildContext for testing without an actual UI
class MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
