import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';
import 'ho_level3.dart';

class HiddenObjectLevel2Screen extends StatefulWidget {
  const HiddenObjectLevel2Screen({super.key});

  @override
  HiddenObjectLevel2ScreenState createState() =>
      HiddenObjectLevel2ScreenState();
}

class HiddenObjectLevel2ScreenState extends State<HiddenObjectLevel2Screen> {
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _timeInSeconds = 300; // 5 minutes
  List<String> foundObjects = [];
  String speechText = "Find the hidden objects quickly!";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeInSeconds > 0) {
        setState(() {
          _timeInSeconds--;
        });
      } else {
        _timer.cancel();
        _navigateToMainMenu();
      }
    });
  }

  void _navigateToMainMenu() {
    _audioPlayer.stop();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainMenu()),
      (route) => false,
    );
  }

  Future<void> _onObjectFound(String objectName, String audioPath) async {
    if (!foundObjects.contains(objectName)) {
      setState(() {
        foundObjects.add(objectName);
        speechText = foundObjects.length < 3
            ? "$objectName found! Keep looking!"
            : "All objects found! Click 'Next'!";
      });

      // Play the voice clip
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(audioPath));
    }
  }

  String get timerText {
    int minutes = _timeInSeconds ~/ 60;
    int seconds = _timeInSeconds % 60;
    return "00:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _navigateToMainMenu();
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  AppConstants.hiddenObjectBackgroundLevel1,
                  fit: BoxFit.cover,
                ),
              ),

              // Hidden Objects (Clickable)
              Positioned(
                top: 300,
                left: 250,
                child: GestureDetector(
                  onTap: () => _onObjectFound(AppConstants.hiddenObjectName_1,
                      AppConstants.hiddenObjectVoice_1),
                  child: Image.asset(
                    AppConstants.hiddenObjectImage_1,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                top: 300,
                left: 500,
                child: GestureDetector(
                  onTap: () => _onObjectFound(AppConstants.hiddenObjectName_2,
                      AppConstants.hiddenObjectVoice_2),
                  child: Image.asset(
                    AppConstants.hiddenObjectImage_2,
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                top: 150,
                right: 200,
                child: GestureDetector(
                  onTap: () => _onObjectFound(AppConstants.hiddenObjectName_3,
                      AppConstants.hiddenObjectVoice_3),
                  child: Image.asset(
                    AppConstants.hiddenObjectImage_3,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // UI Elements
              Positioned(
                top: 25,
                left: 25,
                child: IconButton(
                  icon: const Icon(Icons.home, size: 36, color: Colors.white),
                  onPressed: _navigateToMainMenu,
                ),
              ),

              Positioned(
                top: 25,
                right: 25,
                child: IconButton(
                  icon: const Icon(Icons.menu, size: 36, color: Colors.white),
                  onPressed: () {},
                ),
              ),

              Positioned(
                top: 75,
                left: 32,
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    timerText,
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

              const Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Level 2",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ),

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

              Positioned(
                bottom: 180,
                left: 40,
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    speechText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 25,
                right: 25,
                child: ElevatedButton(
                  onPressed: foundObjects.length == 3
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HiddenObjectLevel3Screen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
