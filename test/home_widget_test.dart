import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/controller/home_controller.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/screens/home_screen.dart';

Widget createHomeScreen() => ChangeNotifierProvider<HomeScreenController>(
      create: (context) => HomeScreenController(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  group('HomeScreen Widget Tests', () {

    testWidgets('Testing AppBar Title', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('Movies'), findsOneWidget);
    });

    testWidgets('Testing Company Info Dialog', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('Testing CircularProgressIndicator when movies list is empty', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Testing ListView and Cards after data is loaded', (tester) async {
      final mockMovies = {
        'result': [
          {
            'voting': 123,
            'poster': 'https://example.com/poster.png',
            'title': 'Test Movie',
            'genre': 'Action, Adventure',
            'director': ['John Doe'],
            'stars': ['Jane Doe', 'Doe Ray'],
            'language': 'English',
            'voted': [
              {'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000}
            ],
            'pageViews': 500,
          },
        ],
      };

      final homeController = HomeScreenController();
      homeController.setMovies(mockMovies);

      await tester.pumpWidget(
        ChangeNotifierProvider<HomeScreenController>.value(
          value: homeController,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(find.text('Test Movie'), findsOneWidget);
    });

    testWidgets('Testing RefreshIndicator', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      final finder = find.byType(RefreshIndicator);
      expect(finder, findsOneWidget);

      await tester.drag(finder, const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Testing Watch Trailer button', (tester) async {
      final mockMovies = {
        'result': [
          {
            'voting': 123,
            'poster': 'https://example.com/poster.png',
            'title': 'Test Movie',
            'genre': 'Action, Adventure',
            'director': ['John Doe'],
            'stars': ['Jane Doe', 'Doe Ray'],
            'language': 'English',
            'voted': [
              {'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000}
            ],
            'pageViews': 500,
          },
        ],
      };

      final homeController = HomeScreenController();
      homeController.setMovies(mockMovies);

      await tester.pumpWidget(
        ChangeNotifierProvider<HomeScreenController>.value(
          value: homeController,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final watchTrailerButton = find.text('Watch Trailer');
      expect(watchTrailerButton, findsOneWidget);

      await tester.tap(watchTrailerButton);
      await tester.pumpAndSettle();
    });
  });
}
