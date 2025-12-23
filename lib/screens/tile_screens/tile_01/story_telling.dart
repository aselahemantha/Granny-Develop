import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';
import '../../../utils/enum/story_enum.dart';

class MyLandscapeScreen extends StatefulWidget {
  const MyLandscapeScreen({super.key});

  @override
  MyLandscapeScreenState createState() => MyLandscapeScreenState();
}

class MyLandscapeScreenState extends State<MyLandscapeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentPageIndex = 0;
  bool stopMusic = false;

  @override
  void initState() {
    super.initState();
    _playMusicWithDelay();
  }

  Future<void> _playMusicWithDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!stopMusic) {
      await _audioPlayer.play(AssetSource(StoryEnum.values[currentPageIndex].backgroundVoice));
    }
  }

  void _toggleMusic() {
    setState(() {
      stopMusic = !stopMusic;
    });

    if (stopMusic) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  void _changePage(int change) {
    int newPageIndex = currentPageIndex + change;

    if (newPageIndex >= 0 && newPageIndex < StoryEnum.values.length) {
      setState(() {
        currentPageIndex = newPageIndex;
      });

      _audioPlayer.stop();
      _playMusicWithDelay();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StoryEnum currentStory = StoryEnum.values[currentPageIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              currentStory.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          // Top Left Home Icon
          Positioned(
            top: 25,
            left: 25,
            child: IconButton(
              icon: const Icon(Icons.home, size: 36, color: Colors.white),
              onPressed: () {
                _audioPlayer.stop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                      (route) => false,
                );
              },
            ),
          ),

          // Top Right Music Icon
          Positioned(
            top: 25,
            right: 25,
            child: IconButton(
              icon: const Icon(Icons.menu,
                  size: 30, color: Colors.white),
              onPressed: () {
                // Handle menu pressed
              },
            ),
          ),

          // Top Left Page Number
          Positioned(
            top: 75,
            left: 32,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                "${currentPageIndex + 1}/${StoryEnum.values.length}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bottom Left Character Icon
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              AppConstants.grannyCharacterImage,
              fit: BoxFit.cover,
              height: 172,
              width: 114,
            ),
          ),

          // Bottom Center Label and Buttons
          Positioned(
            bottom: -20,
            left: 90,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Button
                IconButton(
                  icon: const Icon(Icons.arrow_left, size: 80, color: Colors.white),
                  onPressed: currentPageIndex > 0 ? () => _changePage(-1) : null,
                ),

                // Center Story Text
                Expanded(
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      currentStory.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Right Button
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 80, color: Colors.white),
                  onPressed: currentPageIndex < StoryEnum.values.length - 1 ? () => _changePage(1) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
