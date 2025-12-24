class Song {
  final String title;
  final String videoPath;
  final String? albumArtPath;

  Song({
    required this.title,
    required this.videoPath,
    this.albumArtPath,
  });
}
