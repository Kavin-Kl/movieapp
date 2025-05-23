import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movieeee/models/movie.dart';
import 'package:movieeee/screens/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List movies = [];
  List filteredMovies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=ccd7139859c7a44a0218e943cf28e248"),
    );

    if (response.statusCode == 200) {
      setState(() {
        movies = jsonDecode(response.body)['results'];
        filteredMovies = movies;
      });
    } else {
      print("Failed to load movies: ${response.statusCode}");
    }
  }

  void _searchMovies(String query) {
    setState(() {
      filteredMovies = movies
          .where((movie) => movie['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _searchMovies,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
            ),
            Expanded(
              child: movies.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          var movie = filteredMovies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    movie: Movie(
                                      id: movie['id'],
                                      title: movie['title'],
                                      imageUrl: movie['poster_path'],
                                      overview: movie['overview'],
                                      genres: List<String>.from(
                                          movie['genre_ids']
                                              .map((id) => id.toString())),
                                      rating: movie['vote_average'].toDouble(),
                                      releaseYear:
                                          DateTime.parse(movie['release_date'])
                                              .year,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: MovieCard(movie),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class MovieCard extends StatelessWidget {
  final Map movie;
  const MovieCard(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.error, size: 50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie['title'] ?? 'Unknown',
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
