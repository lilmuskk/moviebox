import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import 'genre_detail_page.dart';
import 'movie_detail_page.dart'; // IMPORT HALAMAN DETAIL

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  Map<String, List<Movie>> groupedMovies = {};

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    List<Movie> allMovies = await MovieService.fetchMovies();
    setState(() {
      groupedMovies = groupMoviesByGenre(allMovies);
    });
  }

  Map<String, List<Movie>> groupMoviesByGenre(List<Movie> movies) {
    Map<String, List<Movie>> result = {};
    for (var movie in movies) {
      if (!result.containsKey(movie.genre)) {
        result[movie.genre] = [];
      }
      result[movie.genre]!.add(movie);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie List")),
      body: groupedMovies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: groupedMovies.entries.map((entry) {
            final genre = entry.key;
            final movies = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ROW GENRE + LIHAT SEMUA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        genre,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenreDetailPage(
                                genre: genre,
                                movies: movies,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  // LIST FILM HORIZONTAL
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(movie: movie),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    movie.imageUrl,
                                    height: 160,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  movie.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${movie.year}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
