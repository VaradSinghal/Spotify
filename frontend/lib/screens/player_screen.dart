import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../services/audio_service.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    AudioService.positionStream.listen((p) => setState(() => _position = p));
    AudioService.durationStream.listen((d) => setState(() => _duration = d));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final song = provider.currentSong;

    return Scaffold(
      appBar: AppBar(title: Text('Now Playing')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (song != null) ...[
            CachedNetworkImage(imageUrl: song.artwork ?? '', height: 200, width: 200),
            SizedBox(height: 20),
            Text(song.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(song.artist, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Slider(
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble(),
              onChanged: (value) => AudioService.seek(Duration(seconds: value.toInt())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    // Implement previous song logic
                  },
                ),
                IconButton(
                  icon: Icon(AudioService.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (AudioService.isPlaying) {
                      AudioService.pause();
                    } else {
                      if (_position == Duration.zero) AudioService.play(song);
                      else AudioService.resume();
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    // Implement next song logic
                  },
                ),
              ],
            ),
          ] else
            Text('No song selected'),
        ],
      ),
    );
  }
}