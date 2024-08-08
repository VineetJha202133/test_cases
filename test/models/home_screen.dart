import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/controller/home_controller.dart';

void main() {
  group('HomeScreenController Unit Tests', () {
    late HomeScreenController homeController;

    setUp(() {
      homeController = HomeScreenController();
    });

    test('Initial state of movies should be empty', () {
      expect(homeController.movies, isEmpty);
    });

    test('Fetching movies updates the movies list', () async {
      await homeController.fetchMovies();
      expect(homeController.movies, isNotEmpty);
    });

    test('Check if the first movie data is correct', () async {
      await homeController.fetchMovies();
      final firstMovie = homeController.movies['result'][0];
      expect(firstMovie['title'], equals('Expected Movie Title'));
      expect(firstMovie['voting'], equals(123));
    });

    test('fetchMovies handles errors correctly', () async {
      try {
        await homeController.fetchMovies();
      } catch (e) {
        expect(homeController.movies, isEmpty);
      }
    });

    test('Fetching movies twice should not duplicate the list', () async {
      await homeController.fetchMovies();
      final firstFetchCount = homeController.movies['result'].length;
      
      await homeController.fetchMovies();
      final secondFetchCount = homeController.movies['result'].length;

      expect(firstFetchCount, equals(secondFetchCount));
    });
  });
}
