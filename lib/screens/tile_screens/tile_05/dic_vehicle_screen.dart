import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../utils/app_constants.dart';

class DictionaryVehicleMenu extends StatefulWidget {
  const DictionaryVehicleMenu({super.key});

  @override
  DictionaryVehicleMenuState createState() => DictionaryVehicleMenuState();
}

class DictionaryVehicleMenuState extends State<DictionaryVehicleMenu> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound(String audioPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(audioPath));
  }

  void _showPopup(BuildContext context, String imagePath, String label, String englishAudioPath, String sinhalaAudioPath) {
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
            width: 600,
            height: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          decorationColor: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () => _playSound(englishAudioPath),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    imagePath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          decorationColor: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () => _playSound(sinhalaAudioPath),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) => _audioPlayer.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstants.dictionaryMainMenuBackground,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 600,
                      height: 300,
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          childAspectRatio: 1,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final imagePath = AppConstants.dictionaryVehicleImages[index];
                          final label = AppConstants.dictionaryVehicleLabels[index];
                          final englishAudioPath = AppConstants.dictionaryVehicleEnglishVoices[index];
                          final sinhalaAudioPath = AppConstants.dictionaryVehicleSinhalaVoices[index];

                          return GestureDetector(
                            onTap: () {
                              _showPopup(context, imagePath, label, englishAudioPath, sinhalaAudioPath);
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
                                  imagePath,
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
