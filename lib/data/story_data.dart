import '../models/story_model.dart';
import '../utils/app_constants.dart';

List<Story> getStories() {
  return [
    _createStory(
      title: "Bunny’s Adventures",
      folder: "story01",
      hasCover: true,
      sceneCount: 10,
    ),
    _createStory(
      title: "Chamri and the wolf",
      folder: "story02",
      hasCover: false,
      sceneCount: 13,
    ),
    _createStory(
      title: "Gayani and Three bears",
      folder: "story03",
      hasCover: false,
      sceneCount: 14,
    ),
    _createStory(
      title: "Grandpa and the Fireflies",
      folder: "story04",
      hasCover: false,
      sceneCount: 6,
    ),
    _createStory(
      title: "Kavin and the Beanstalk",
      folder: "story05",
      hasCover: false,
      sceneCount: 13,
    ),
    _createStory(
      title: "Nimal and Nadee",
      folder: "story06",
      hasCover: false,
      sceneCount: 8,
    ),
    _createStory(
      title: "Nimal and the Whispering Tree",
      folder: "story07",
      hasCover: false,
      sceneCount: 6,
    ),
    _createStory(
      title: "Nuwan and the Night Sounds",
      folder: "story08",
      hasCover: false,
      sceneCount: 5,
    ),
    _createStory(
      title: "Podi and the Rain Cloud",
      folder: "story09",
      hasCover: false,
      sceneCount: 5,
    ),
    _createStory(
      title: "Savi and the Sleepy Elephant",
      folder: "story10",
      hasCover: false,
      sceneCount: 8,
    ),
    _createStory(
      title: "The Ant and the Grasshopper",
      folder: "story11",
      hasCover: true,
      sceneCount: 8,
    ),
    _createStory(
      title: "The Clay Pot Princess",
      folder: "story12",
      hasCover: false,
      sceneCount: 6,
    ),
    _createStory(
      title: "The Coconut Thief",
      folder: "story13",
      hasCover: false,
      sceneCount: 5,
    ),
    _createStory(
      title: "The Day the River Sang",
      folder: "story14",
      hasCover: false,
      sceneCount: 5,
    ),
    _createStory(
      title: "The Fisherman and His Wife",
      folder: "story15",
      hasCover: true,
      sceneCount: 14,
    ),
    _createStory(
      title: "The Giving Tree",
      folder: "story16",
      hasCover: true,
      sceneCount: 9,
    ),
    _createStory(
      title: "The Lion and the Mouse",
      folder: "story17",
      hasCover: false,
      sceneCount: 10,
    ),
    _createStory(
      title: "The Little Red Hen",
      folder: "story18",
      hasCover: true,
      sceneCount: 12,
    ),
    _createStory(
      title: "The Lost Turtle",
      folder: "story19",
      hasCover: false,
      sceneCount: 9,
    ),
    _createStory(
      title: "The Magic Umbrella",
      folder: "story20",
      hasCover: false,
      sceneCount: 8,
    ),
    _createStory(
      title: "The Mango Friends",
      folder: "story21",
      hasCover: true,
      sceneCount: 10,
    ),
    _createStory(
      title: "The Three Little Pigs and the Hungry Jackal",
      folder: "story22",
      hasCover: false,
      sceneCount: 17,
    ),
    _createStory(
      title: "The Three Talking Trees",
      folder: "story23",
      hasCover: false,
      sceneCount: 7,
    ),
  ];
}

Story _createStory({
  required String title,
  required String folder,
  required bool hasCover,
  required int sceneCount,
}) {
  final String basePath = 'assets/images/story_telling/$folder';
  
  // Use specific naming convention: storyXX_cover.png or storyXX_scene01.png
  String coverImage = hasCover 
      ? '$basePath/${folder}_cover.png' 
      : '$basePath/${folder}_scene01.png';
      
  List<StoryPage> pages = [];
  
  for (int i = 1; i <= sceneCount; i++) {
    // Determine which text and audio to use (cycling through available constants)
    int textIndex = (i - 1) % AppConstants.storyTexts.length;
    int voiceIndex = (i - 1) % AppConstants.storyVoices.length;
    
    // Check if scene exists (we assume sequential naming from migration script)
    // Naming: storyXX_sceneYY.png
    String sceneName = '${folder}_scene${i.toString().padLeft(2, '0')}.png';
    
    pages.add(StoryPage(
      imagePath: '$basePath/$sceneName',
      audioPath: AppConstants.storyVoices[voiceIndex],
      text: AppConstants.storyTexts[textIndex],
    ));
  }

  return Story(
    title: title,
    coverImage: coverImage,
    pages: pages,
  );
}
