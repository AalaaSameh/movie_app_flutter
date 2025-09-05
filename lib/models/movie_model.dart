class Movie {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> genres;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.genres,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description_full'] ?? '',
      imageUrl: json['medium_cover_image'] ?? "",
      genres: (json['genres'] as List?)?.map((g) => g.toString()).toList() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
