import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../utils/app_constants.dart';
import '../../main_menu.dart';

class Alphabet extends StatefulWidget {
  const Alphabet({super.key});

  @override
  AlphabetState createState() => AlphabetState();
}

class AlphabetState extends State<Alphabet> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playLetterSound(String audioPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(audioPath));
  }

  void _showPopup(BuildContext context, String letter, String letterImagePath,
      String letterBodyImagePath, String label, String audioPath) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        Future.delayed(const Duration(seconds: 5), () {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      letterImagePath,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      letterBodyImagePath,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 60),
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _playLetterSound(audioPath);
                      },
                    ),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) => _audioPlayer.stop());
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstants.alphabetBackground,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home,
                            size: 30, color: Colors.white),
                        onPressed: () {
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
                          // Handle menu button press
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 680,
                          height: 250,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 9,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1,
                            ),
                            itemCount: 26,
                            itemBuilder: (context, index) {
                              final letter = String.fromCharCode(65 + index);
                              final letterImagePath =
                                  AppConstants.letterImages[index];
                              final letterBodyImagePath =
                                  AppConstants.letterBodyImages[index];
                              final label = AppConstants.letterLabels[index];
                              final audioPath =
                                  AppConstants.letterVoices[index];

                              return GestureDetector(
                                onTap: () {
                                  _showPopup(context, letter, letterImagePath,
                                      letterBodyImagePath, label, audioPath);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    letterImagePath,
                                    fit: BoxFit.cover,
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
