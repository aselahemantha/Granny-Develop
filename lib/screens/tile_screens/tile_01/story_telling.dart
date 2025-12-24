import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';
import '../../../models/story_model.dart';

class MyLandscapeScreen extends StatefulWidget {
  final Story story;

  const MyLandscapeScreen({super.key, required this.story});

  @override
  MyLandscapeScreenState createState() => MyLandscapeScreenState();
}

class MyLandscapeScreenState extends State<MyLandscapeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentPageIndex = 0;
  bool stopMusic = false;

  List<StoryPage> get _pages => widget.story.pages;

  @override
  void initState() {
    super.initState();
    _playMusicWithDelay();
  }

  Future<void> _playMusicWithDelay() async {
    await Future.delayed(const Duration(seconds: 1)); // Reduced delay for better UX
    if (!stopMusic && mounted) {
      final audioPath = _pages[currentPageIndex].audioPath;
      if (audioPath != null) {
        await _audioPlayer.play(AssetSource(audioPath));
      }
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

    if (newPageIndex >= 0 && newPageIndex < _pages.length) {
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
    StoryPage currentPage = _pages[currentPageIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              currentPage.imagePath,
              fit: BoxFit.contain,
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
              icon: Icon(stopMusic ? Icons.volume_off : Icons.volume_up,
                  size: 30, color: Colors.white),
              onPressed: _toggleMusic,
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
                "${currentPageIndex + 1}/${_pages.length}",
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
                    height: 80, // Increased height for better text fit
                    color: Colors.white.withOpacity(0.9),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Text(
                        currentPage.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // Right Button
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 80, color: Colors.white),
                  onPressed: currentPageIndex < _pages.length - 1 ? () => _changePage(1) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
