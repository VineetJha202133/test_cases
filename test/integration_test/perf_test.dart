import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_geeksynergy_task/main.dart';  // Adjust the import based on your main file location.

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('App Performance Test', () {
    testWidgets('Home Screen Scrolling Performance Test', (tester) async {
      await tester.pumpWidget(MyApp());

      // Log in to reach the Home Screen
      await tester.enterText(find.byKey(Key('loginNameField')), 'John Doe');
      await tester.enterText(find.byKey(Key('loginPasswordField')), 'password123');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      
      final listFinder = find.byType(ListView);

      
      await binding.traceAction(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000); // Scroll up
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000); // Scroll down
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });
  });
}
