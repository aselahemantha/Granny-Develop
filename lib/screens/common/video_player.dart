import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  // Pass the video URL from outside
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the video player with the passed video URL
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);

    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    await _videoPlayerController.initialize();

    // Initialize ChewieController after the VideoPlayerController is ready
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true, // Ensure autoplay is enabled
      looping: true,
      fullScreenByDefault: true,
    );

    setState(() {}); // Trigger rebuild to display the video
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose(); // Dispose of the ChewieController if it exists
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video player
          if (_chewieController != null)
            Chewie(
              controller: _chewieController!,
            )
          else
            const Center(
              child: CircularProgressIndicator(), // Show loading indicator while initializing
            ),

          // Foreground content (icons and tiles)
          SafeArea(
            child: Column(
              children: [
                // Top bar with icons
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          // Navigate back to the previous screen
                          Navigator.pop(context);
                        },
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