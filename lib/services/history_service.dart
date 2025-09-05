import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class HistoryService {
  static const String historyKey = "movie_history";

  static Future<void> addToHistory(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyList = prefs.getStringList(historyKey) ?? [];

    final movieJson = json.encode(movie.toJson());

    historyList.removeWhere((item) => item.contains('"id":${movie.id}'));

    historyList.insert(0, movieJson);

    if (historyList.length > 20) {
      historyList = historyList.sublist(0, 20);
    }

    await prefs.setStringList(historyKey, historyList);
  }

  static Future<List<Movie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList(historyKey) ?? [];

    return historyList
        .map((movieStr) => Movie.fromJson(json.decode(movieStr)))
        .toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(historyKey);
  }
}
