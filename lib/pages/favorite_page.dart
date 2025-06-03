import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/favorite_service.dart';
import '../services/movie_service.dart';
import 'movie_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Movie> _favoriteMovies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    setState(() {
      _loading = true;
    });

    final allMovies = await MovieService.fetchMovies();
    final favoriteIds = FavoriteService().favoriteIds;
    _favoriteMovies = allMovies.where((movie) => favoriteIds.contains(movie.id)).toList();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_favoriteMovies.isEmpty) {
      return Center(child: Text('Belum ada favorit nih'));
    }

    return ListView.builder(
      itemCount: _favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = _favoriteMovies[index];
        return ListTile(
          leading: Image.network(movie.imageUrl, width: 50, fit: BoxFit.cover),
          title: Text(movie.title),
          subtitle: Text('${movie.genre} • ${movie.year}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () async {
              await FavoriteService().removeFavorite(movie.id);
              await loadFavorites();
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(movie: movie)),
            );
          },
        );
      },
    );
  }
}
