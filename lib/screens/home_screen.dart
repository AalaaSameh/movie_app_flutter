import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utils/app_colors.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> moviesFuture;

  // Genres list
  final List<String> genres = ["Action", "Comedy", "Drama", "Horror", "Sci-Fi"];
  String selectedGenre = "Action";

  @override
  void initState() {
    super.initState();
    moviesFuture = MovieService.fetchMoviesByGenre(selectedGenre);
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: FutureBuilder<List<Movie>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.amberColor),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No movies found",
                    style: TextStyle(color: AppColors.whiteColor)),
              );
            }

            final movies = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Available Now",
                        style: GoogleFonts.dancingScript(textStyle: const TextStyle(
                          fontSize: 40,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),

                  // Carousel Slider
                  CarouselSlider(
                    items: movies.take(5).map((movie) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              movie.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.amberColor, size: 16),
                                Text("${movie.rating}",
                                    style:
                                    const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 400, enlargeCenterPage: true, autoPlay: true),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Watch Now",
                        style: GoogleFonts.dancingScript(textStyle: const TextStyle(
                          fontSize: 50,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),

                  // Genre Selector
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        final isSelected = genre == selectedGenre;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGenre = genre;
                              moviesFuture =
                                  MovieService.fetchMoviesByGenre(genre);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                              isSelected ? AppColors.amberColor : Colors.grey[800],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color:
                                isSelected ? AppColors.blackColor : AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
