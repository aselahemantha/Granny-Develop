import '../models/story_model.dart';
import '../utils/app_constants.dart';

List<Story> getStories() {
  // Use existing assets for all stories since we want a list of 10
  // In a real app, these would be different.
  
  // Recreating the original 3-page story
  List<StoryPage> ammaAuruduStory = [
    StoryPage(
      imagePath: AppConstants.story1Images[0],
      audioPath: AppConstants.storyVoices[0],
      text: AppConstants.storyTexts[0],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[1],
      audioPath: AppConstants.storyVoices[1],
      text: AppConstants.storyTexts[1],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[2],
      audioPath: AppConstants.storyVoices[2],
      text: AppConstants.storyTexts[2],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[3],
      audioPath: AppConstants.storyVoices[0],
      text: AppConstants.storyTexts[0],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[4],
      audioPath: AppConstants.storyVoices[1],
      text: AppConstants.storyTexts[1],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[5],
      audioPath: AppConstants.storyVoices[2],
      text: AppConstants.storyTexts[2],
    ),
    StoryPage(
      imagePath: AppConstants.story1Images[6],
      audioPath: AppConstants.storyVoices[2],
      text: AppConstants.storyTexts[2],
    ),
  ];

  return [
    Story(
      title: 'Amma’s Avurudu Surprise',
      coverImage: AppConstants.story1CoverImage,
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'The Lion & Mouse',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Thirsty Crow',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Greedy Dog',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Fox & Grapes',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Proud Rose',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Milkmaid & Pail',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Golden Egg',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Bear & Two Friends',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
    Story(
      title: 'Ant & Grasshopper',
      coverImage: 'assets/images/story1.jpg',
      pages: ammaAuruduStory,
    ),
  ];
}
