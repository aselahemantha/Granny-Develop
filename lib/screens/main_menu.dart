import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_constants.dart';
import '../providers/music_provider.dart';
import 'tile_screens/tile_08/setting.dart';
import 'tile_screens/tile_01/story_telling.dart';
import 'tile_screens/tile_01/thumbnail_selection_screen.dart';
import 'tile_screens/tile_02/alphabet.dart';
import 'tile_screens/tile_03/shape_color_menu.dart';
import 'tile_screens/tile_04/sing_along.dart';
import 'tile_screens/tile_05/dic_select_menu.dart';
import 'tile_screens/tile_06/ho_level1.dart';
import 'tile_screens/tile_07/kids_tv.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstants.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 30, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          musicProvider.isMusicEnabled ? Icons.music_note : Icons.music_off,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          musicProvider.toggleMusic(!musicProvider.isMusicEnabled);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 500,
                      height: 250,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          childAspectRatio: 1,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ThumbnailSelectionScreen()));
                                  break;
                                case 1:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Alphabet()));
                                  break;
                                case 2:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ShapeColorMenu()));
                                  break;
                                case 3:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SingAlong()));
                                  break;
                                case 4:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DictionaryMenu()));
                                  break;
                                case 5:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HiddenObjectLevel1Screen()));
                                  break;
                                case 6:
                                  musicProvider.toggleMusic(false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const KidsTv()));
                                  break;
                                case 7:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('You clicked on item ${index + 1}')),
                                  );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  AppConstants.tileImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
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
}
