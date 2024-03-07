import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        httpHeaders: {"Authorization": "334583943739261"},
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: flickManager,
    );
  }
}
