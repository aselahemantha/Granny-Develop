import 'package:Granny/screens/common/video_player.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';

class SingAlong extends StatelessWidget {
  const SingAlong({super.key});

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
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 25,
                              childAspectRatio: 1,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {

                              String videoUrl = AppConstants.songKaraokeList[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlayerScreen(
                                              videoUrl: videoUrl,
                                            )),
                                  );
                                  // Handle different actions based on index
                                  // switch (index) {
                                  //   case 0:
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //           VideoPlayerScreen(
                                  //             videoUrl: videoUrl,
                                  //           )),
                                  //     );
                                  //     break;
                                  //     break;
                                  //   case 1:
                                  //     // To be Implement
                                  //     break;
                                  //   case 2:
                                  //     // To be Implement
                                  //     break;
                                  //   case 3:
                                  //     // To be Implement
                                  //     break;
                                  //   case 4:
                                  //     // To be Implement
                                  //     break;
                                  //   case 5:
                                  //   // To be Implement
                                  //     break;
                                  // // Add more cases as needed for other items
                                  //   default:
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(
                                  //       SnackBar(
                                  //         content: Text(
                                  //             'You clicked on item ${index + 1}'),
                                  //       ),
                                  //     );
                                  // }
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
                                    child: Image.asset(
                                      AppConstants.songAlbumArt[index],
                                      fit: BoxFit.cover,
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
