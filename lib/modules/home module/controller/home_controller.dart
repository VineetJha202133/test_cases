import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreenController with ChangeNotifier{

  Map<String, dynamic> _movies = {};
  get movies => _movies;
  setMovies(newVal){
    _movies = newVal;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting'
      }),
    );

    if (response.statusCode == 200) {
      log(response.body);
     
        _movies.clear();
        _movies = jsonDecode(response.body);
     notifyListeners();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}