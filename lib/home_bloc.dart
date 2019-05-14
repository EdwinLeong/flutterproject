import 'dart:convert';
import 'dart:core';

import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:projec_04/home.dart';

class Movie {
  Movie({
    @required this.id,
    @required this.title,
    this.popularity,
    this.posterPath,
    this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
      id: parsedJson['id'],
      title: parsedJson['title'],
      posterPath: parsedJson['poster_path'],
      popularity: parsedJson['popularity'],
      overview: parsedJson['overview'],
    );
  }

  final int id;
  final String title;
  final String posterPath;
  final double popularity;
  final String overview;
}

class HomeBloc {
  final BehaviorSubject<List<Movie>> _movieSubject =
      BehaviorSubject<List<Movie>>();

  void setMovies(List<Movie> value) {
    _movieSubject.sink.add(value);
  }

  Stream<List<Movie>> get getMovies => _movieSubject.stream;

  Future<void> fetchData() async {
    final http.Response resp = await http.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=f66899a2cf55b0f156b8042d09110569');

    final Map<String, dynamic> jsonObj = jsonDecode(resp.body);
    final List<Object> results = jsonObj['results'];

    await Future<dynamic>.delayed(Duration(seconds: 2));

    final List<Movie> movies =
        results.map((dynamic f) => Movie.fromJson(f)).toList();

    setMovies(movies);
    return;
  }
}
