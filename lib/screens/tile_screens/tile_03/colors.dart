import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';

class IdentifyColors extends StatefulWidget {
  const IdentifyColors({super.key});

  @override
  _IdentifyColorsState createState() => _IdentifyColorsState();
}

class _IdentifyColorsState extends State<IdentifyColors> {
  // State variables to store the selected color's image and title
  String selectedImage = AppConstants.colors[0].image;
  String selectedTitle = AppConstants.colors[0].name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.backgroundImage, // Use constant for image path
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
                      horizontal: 16.0, vertical: 8.0), // Adjust padding here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          // Handle home button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainMenu()),
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

                // Reduced spacing between sections
                const SizedBox(height: 0), // Reduced gap between top bar and content

                // Main content with two large boxes closer to the top
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the boxes horizontally
                        children: [
                          // Left box with title and grid view
                          Container(
                            width: 260, // Set width of the box
                            height: 260, // Set height of the box
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Title at the top of the left box
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Colors',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                
                                const SizedBox(height: 5),
                                // Grid view inside the left box
                                Expanded(
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // 3 items per row
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.2, // Ensures square aspect ratio
                                    ),
                                    itemCount: AppConstants.colors.length, // 9 items
                                    itemBuilder: (context, index) {
                                      final color = AppConstants.colors[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Update the state with the selected color's details
                                          setState(() {
                                            selectedImage = color.image;
                                            selectedTitle = color.name;
                                          });
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Container(
                                            color: Colors.grey[300], // Background color for items
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  color.image, // Use appropriate image
                                                  width: 40, // Fixed size of the image
                                                  height: 40, // Fixed size of the image
                                                  fit: BoxFit.cover, // Keep the aspect ratio intact
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 40), // Space between the two boxes

                          // Right box with image and title
                          Container(
                            width: 260, // Set width of the box
                            height: 260, // Set height of the box
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                // Image in the center of the right box
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    selectedImage, // Dynamically set image
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10), // Space between image and title
                                // Title below the image
                                Text(
                                  selectedTitle, // Dynamically set title
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
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
