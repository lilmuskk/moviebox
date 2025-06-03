class Movie {
  final String id;
  final String title;
  final String genre;
  final int year;
  final String imageUrl;
  final String description;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.imageUrl,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      genre: json['genre'],
      year: int.parse(json['year'].toString()),
      imageUrl: json['imageUrl'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'year': year,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
