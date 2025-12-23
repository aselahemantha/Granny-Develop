import 'package:Granny/screens/tile_screens/tile_05/dic_fruit_screen.dart';
import 'package:Granny/screens/tile_screens/tile_05/dic_vegetables_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';
import 'dic_tool_screen.dart';
import 'dic_vehicle_screen.dart';

class DictionaryMenu extends StatelessWidget {
  const DictionaryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.selectDictionaryMenuBackground,
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
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 30, color: Colors.white),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainMenu()),
                                (route) => false,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu, size: 30, color: Colors.white),
                        onPressed: () {
                          // Handle menu button press
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Main content (scrollable text boxes)
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          _buildTextBox(context, "Vehicles", const DictionaryVehicleMenu()),
                          _buildTextBox(context, "Fruits", const DictionaryFruitMenu()),
                          _buildTextBox(context, "Vegetables", const DictionaryVegetablesMenu()),
                          _buildTextBox(context, "Tools", const DictionaryToolMenu()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBox(BuildContext context, String text, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              decorationColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}