import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/presentation/widgets/custom_video_player_controls.dart';
import 'package:tweel_social_media/presentation/widgets/data_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  late DataManager dataManager;

  @override
  void initState() {
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        httpHeaders: {"Authorization": "334583943739261"},
      ),
    );
    dataManager =
        DataManager(flickManager: flickManager, urls: [widget.videoUrl]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickManager.flickControlManager?.pause();
        }
      },
      child: FlickVideoPlayer(
        preferredDeviceOrientationFullscreen: const [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        flickVideoWithControls: FlickVideoWithControls(
          controls: CustomOrientationControls(dataManager: dataManager),
        ),
        flickVideoWithControlsFullscreen: FlickVideoWithControls(
          videoFit: BoxFit.fitWidth,
          controls: CustomOrientationControls(dataManager: dataManager),
        ),
        flickManager: flickManager,
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}
