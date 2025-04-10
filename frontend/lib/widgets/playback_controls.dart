import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
        IconButton(
          icon: Icon(AudioService.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (AudioService.isPlaying) AudioService.pause();
            else AudioService.resume();
          },
        ),
        IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
      ],
    );
  }
}