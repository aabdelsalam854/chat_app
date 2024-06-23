import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class IsRecord extends StatefulWidget {
  const IsRecord({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<IsRecord> createState() => _IsRecordState();
}

class _IsRecordState extends State<IsRecord> {
  double fastPlay = 1;
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();

  startPlay() async {
    await audioPlayer.play(UrlSource(widget.message));
  }

  resumePlay() async {
    await audioPlayer.resume();
  }

  speedPlay() async {
    await audioPlayer.setPlaybackRate(fastPlay);
  }

  pausePlay() async {
    await audioPlayer.pause();
  }

  stopPlay() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            child: IconButton(
          onPressed: () async {
            if (!isPlaying) {
              await startPlay();
              setState(() {
                isPlaying = true;
              });
            } else {
              await stopPlay();
              setState(() {
                isPlaying = false;
              });
            }
          },
          icon: isPlaying
              ? const Icon(Icons.stop)
              : const Icon(Icons.play_arrow),
        )),
        const Spacer(),
        IconButton(
          onPressed: () async {
            await resumePlay();
          },
          icon: const Icon(Icons.play_arrow),
        ),
        IconButton(
          onPressed: () async {
            await pausePlay();
          },
          icon: const Icon(Icons.pause),
        ),
        IconButton(
          onPressed: () async {
            await speedPlay();
            setState(() {
              fastPlay == 1 ? fastPlay = 2 : fastPlay = 1;
            });
          },
          icon: const Icon(Icons.speed),
        ),
      ],
    );
  }
}
