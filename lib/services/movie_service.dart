import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = "https://yts.mx/api/v2";

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse("$baseUrl/list_movies.json"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['data']['movies'];
      return movies.map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  static Future<List<Movie>> fetchMoviesByQuery(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/list_movies.json?query_term=$query"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? movies = data['data']['movies'];
      return movies != null
          ? movies.map((m) => Movie.fromJson(m)).toList()
          : [];
    } else {
      throw Exception("Failed to load movies");
    }
  }


  static Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    final response = await http.get(
      Uri.parse("$baseUrl/list_movies.json?genre=$genre"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? movies = data['data']['movies'];
      return movies != null
          ? movies.map((m) => Movie.fromJson(m)).toList()
          : [];
    } else {
      throw Exception("Failed to load movies by genre");
    }
  }

  static Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie_details.json?movie_id=$movieId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movie'];
      return Movie.fromJson(data);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  static Future<List<Movie>> fetchMovieSuggestions(int movieId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie_suggestions.json?movie_id=$movieId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movies'];
      return (data as List).map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load suggestions");
    }
  }
}
