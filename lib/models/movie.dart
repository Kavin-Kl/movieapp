class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final int releaseYear;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.releaseYear,
  });
}
