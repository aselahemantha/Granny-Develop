import '../app_constants.dart';

enum StoryEnum {
  page1(
    imageIndex: 0,
    voiceIndex: 0,
    textIndex: 0,
  ),
  page2(
    imageIndex: 1,
    voiceIndex: 1,
    textIndex: 1,
  ),
  page3(
    imageIndex: 2,
    voiceIndex: 2,
    textIndex: 2,
  );

  final int imageIndex;
  final int voiceIndex;
  final int textIndex;

  const StoryEnum({
    required this.imageIndex,
    required this.voiceIndex,
    required this.textIndex,
  });

  String get backgroundImage => AppConstants.storyImages[imageIndex];
  String get backgroundVoice => AppConstants.storyVoices[voiceIndex];
  String get text => AppConstants.storyTexts[textIndex];
}
