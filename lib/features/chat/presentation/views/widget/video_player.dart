import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.videoUrl, required this.local});

  final dynamic videoUrl;
  final bool? local;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;
  late final Chewie videoPlayer;
  bool initialized = false;

  void initVideo() {
    videoPlayerController = widget.local!
        ? VideoPlayerController.file(widget.videoUrl)
        : VideoPlayerController.network(widget.videoUrl);

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isInitialized) {
        setState(() {
          initialized = true;
        });
      }
    });

    // Initialize the VideoPlayerController
    videoPlayerController.initialize().then((_) {
      setState(() {
        initialized = true;
      });
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    videoPlayer = Chewie(controller: chewieController);
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();

    super.dispose();
  }

  void close() {
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: initialized
          ? Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: SizedBox(
                            height: 150, width: 150, child: videoPlayer),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
