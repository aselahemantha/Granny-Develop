import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';

class MergedShapes extends StatefulWidget {
  const MergedShapes({super.key});

  @override
  _MergedShapesState createState() => _MergedShapesState();
}

class _MergedShapesState extends State<MergedShapes> {
  // Separate state variables for selected shape and color
  String selectedShapeImage = AppConstants.shapes[0].image;
  String selectedShapeTitle = AppConstants.shapes[0].name;

  String selectedColorImage = AppConstants.colors[0].image;
  String selectedColorTitle = AppConstants.colors[0].name;

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

                // Main content with three boxes
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Left box with shapes
                          _buildShapeBox(),
                          const SizedBox(width: 20), // Space between boxes

                          // Middle box with combined title
                          _buildMiddleBox(),

                          const SizedBox(width: 20), // Space between boxes

                          // Right box with colors
                          _buildColorBox(),
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

  Widget _buildShapeBox() {
    return Container(
      width: 250,
      height: 250,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Shapes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemCount: AppConstants.shapes.length,
              itemBuilder: (context, index) {
                final shape = AppConstants.shapes[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedShapeImage = shape.image;
                      selectedShapeTitle = shape.name;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            shape.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
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
    );
  }

  Widget _buildColorBox() {
    return Container(
      width: 250,
      height: 250,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const Padding(
            padding: EdgeInsets.all(8.0),
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
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemCount: AppConstants.colors.length,
              itemBuilder: (context, index) {
                final color = AppConstants.colors[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorImage = color.image;
                      selectedColorTitle = color.name;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            color.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
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
    );
  }

  Widget _buildMiddleBox() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              selectedShapeImage, // Display shape image
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$selectedColorTitle $selectedShapeTitle', // Combined title
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
