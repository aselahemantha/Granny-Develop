class Story {
  final String title;
  final String coverImage;
  final List<StoryPage> pages;

  const Story({
    required this.title,
    required this.coverImage,
    required this.pages,
  });
}

class StoryPage {
  final String imagePath;
  final String? audioPath;
  final String text;

  const StoryPage({
    required this.imagePath,
    this.audioPath,
    required this.text,
  });
}
