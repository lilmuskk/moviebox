import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  static const _prefKey = 'favorite_movies';

  List<String> _favoriteIds = [];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList(_prefKey) ?? [];
  }

  List<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  Future<void> addFavorite(String id) async {
    if (!_favoriteIds.contains(id)) {
      _favoriteIds.add(id);
      await _save();
    }
  }

  Future<void> removeFavorite(String id) async {
    _favoriteIds.remove(id);
    await _save();
  }

  Future<void> toggleFavorite(String id) async {
    if (isFavorite(id)) {
      await removeFavorite(id);
    } else {
      await addFavorite(id);
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefKey, _favoriteIds);
  }
}
