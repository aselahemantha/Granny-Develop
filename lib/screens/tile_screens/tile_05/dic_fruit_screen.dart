import 'package:Granny/screens/tile_screens/tile_05/dic_select_menu.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class DictionaryFruitMenu extends StatelessWidget {
  const DictionaryFruitMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.dictionaryMainMenuBackground,
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
                            MaterialPageRoute(builder: (context) => const DictionaryMenu()),
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
                          width: 600,
                          height: 300,
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 25, // Adjust spacing between rows
                              crossAxisSpacing: 25, // Adjust spacing between columns
                              childAspectRatio: 1,
                            ),
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle different actions based on index
                                  switch (index) {
                                    // case 0:
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //         const MyLandscapeScreen()),
                                    //   );
                                    //   break;
                                  // Add more cases as needed for other items
                                    default:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'You clicked on item ${index + 1}'),
                                        ),
                                      );
                                  }
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
                                      AppConstants.dictionaryFruitsImages[index % AppConstants.dictionaryFruitsImages.length],
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