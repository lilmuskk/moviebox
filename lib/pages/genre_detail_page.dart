import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_detail_page.dart'; // jangan lupa import ini ya

class GenreDetailPage extends StatelessWidget {
  final String genre;
  final List<Movie> movies;

  const GenreDetailPage({super.key, required this.genre, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Genre: $genre")),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: movies.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(movie: movie),
                ),
              );
            },
            borderRadius: BorderRadius.circular(8), // biar animasi ripple nya matching
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.imageUrl,
                    height: 100,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text("${movie.year}", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 4),
                      Text(
                        movie.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
