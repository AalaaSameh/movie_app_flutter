import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = "https://yts.mx/api/v2/list_movies.json";

  // 📌 يجيب كل الأفلام (الافتراضي)
  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['data']['movies'];
      return movies.map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  // 📌 يجيب أفلام بالبحث
  static Future<List<Movie>> fetchMoviesByQuery(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl?query_term=$query"),
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
  // Get movie details
  static Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse("https://yts.mx/api/v2/movie_details.json?movie_id=$movieId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movie'];
      return Movie.fromJson(data);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

// Get movie suggestions
  static Future<List<Movie>> fetchMovieSuggestions(int movieId) async {
    final response = await http.get(
      Uri.parse("https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movies'];
      return (data as List).map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load suggestions");
    }
  }


  // 📌 يجيب أفلام حسب النوع (Action, Comedy ...)
  static Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    final response = await http.get(
      Uri.parse("$baseUrl?genre=$genre"),
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
}
