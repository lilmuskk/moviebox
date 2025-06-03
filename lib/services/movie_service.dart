import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String baseUrl = 'https://683d8169199a0039e9e5bae9.mockapi.io/api/v1/movie/movies';

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Movie.fromJson(data)).toList();
    } else {
      throw Exception('Gagal mengambil data movie');
    }
  }

  static Future<void> addMovie(Movie movie) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(movie.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan movie');
    }
  }

  static Future<void> updateMovie(String id, Movie movie) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(movie.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate movie');
    }
  }

  static Future<void> deleteMovie(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete movie');
    }
  }
}
