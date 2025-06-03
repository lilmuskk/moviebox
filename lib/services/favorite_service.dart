import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _key = 'favorite_movie_ids';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> toggleFavorite(String movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(_key) ?? [];

    if (favs.contains(movieId)) {
      favs.remove(movieId);
    } else {
      favs.add(movieId);
    }

    await prefs.setStringList(_key, favs);
  }

  static Future<bool> isFavorite(String movieId) async {
    final favs = await getFavorites();
    return favs.contains(movieId);
  }
}
