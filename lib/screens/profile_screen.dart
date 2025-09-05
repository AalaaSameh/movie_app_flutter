import 'package:flutter/material.dart';
import 'package:test_project/screens/edit_profile_screen.dart';
import 'package:test_project/utils/app_assets.dart';
import 'package:test_project/utils/app_colors.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';
import '../services/history_service.dart';
import 'package:test_project/utils/app_assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Movie> favorites = [];
  List<Movie> history = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadFavorites();
    loadHistory();
  }

  Future<void> loadFavorites() async {
    final favs = await MovieService.fetchFavorites();
    setState(() {
      favorites = favs;
    });
  }

  Future<void> loadHistory() async {
    final hist = await HistoryService.getHistory();
    setState(() {
      history = hist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ====== Profile Info ======
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("John Safwat",
                          style: TextStyle(color: AppColors.whiteColor, fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("12 Wish List   |   10 History",
                          style: TextStyle(color: AppColors.whiteColor)),
                    ],
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Exit",style: TextStyle(color: AppColors.blackColor),),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TabBar(
              controller: _tabController,
              indicatorColor: Colors.yellow,
              labelColor: Colors.yellow,
              unselectedLabelColor: AppColors.whiteColor,
              tabs: const [
                Tab(icon: ImageIcon(AssetImage(AppAssets.watchListIcon),color: AppColors.amberColor,),text: "Watch List"),
                Tab(icon: ImageIcon(AssetImage(AppAssets.historyIcon),color: AppColors.amberColor),text: "History"),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Watch List Grid
                  favorites.isEmpty
                      ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.popcornImage),
                    ],
                  ))
                      : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: favorites[index]);
                    },
                  ),

                  // History Grid
                  history.isEmpty
                      ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.popcornImage),
                    ],
                  ))
                      : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: history[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
