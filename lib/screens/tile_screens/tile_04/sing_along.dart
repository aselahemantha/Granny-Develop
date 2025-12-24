import 'package:Granny/screens/common/video_player.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';
import '../../../data/song_data.dart';
import '../../../models/song_model.dart';

class SingAlong extends StatefulWidget {
  const SingAlong({super.key});

  @override
  State<SingAlong> createState() => _SingAlongState();
}

class _SingAlongState extends State<SingAlong> {
  late List<Song> songs;

  @override
  void initState() {
    super.initState();
    songs = getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.singAlongBackground,
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content (icons and tiles)
          SafeArea(
            child: Column(
              children: [
                // Top bar with icons
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainMenu()),
                                (route) => false,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          // Handle music button press
                        },
                      ),
                    ],
                  ),
                ),

                // Reduced space between sections
                const SizedBox(height: 8), // Adjust spacing here

                // Main content (grid tiles section)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Align closer to the top
                    children: [
                      Center(
                        child: SizedBox(
                          width: 500,
                          height: 250,
                          child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 25,
                              childAspectRatio: 1,
                            ),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {

                              final song = songs[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlayerScreen(
                                              videoUrl: song.videoPath,
                                            )),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent
                                        .withOpacity(0.8),
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        // Placeholder or Album Art
                                        Image.asset(
                                          'assets/images/songs/song_1.png', // Default placeholder
                                          fit: BoxFit.cover,
                                        ),
                                        // Title overlay
                                        Container(
                                          color: Colors.black38,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            song.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
