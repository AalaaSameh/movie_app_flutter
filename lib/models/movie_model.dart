class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final String? description;
  final String? summary;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.summary,
    this.description,
    this.genres = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      imageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0).toDouble(),

      summary: json['description_full'] ?? '',
      description: json['description_full'],


      genres: (json['genres'] != null)
          ? List<String>.from(json['genres'])
          : [],
    );
  }
}
