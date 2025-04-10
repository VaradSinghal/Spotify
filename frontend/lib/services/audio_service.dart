import 'package:audioplayers/audioplayers.dart';
import '../models/song.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();
  static Song? currentSong;
  static bool _isPlaying = false;

  static bool get isPlaying => _isPlaying;

  static Future<void> play(Song song) async {
    currentSong = song;
    await _player.play(UrlSource(song.url));
    _isPlaying = true;
  }

  static Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
  }

  static Future<void> resume() async {
    await _player.resume();
    _isPlaying = true;
  }

  static Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
  }

  static Future<void> seek(Duration position) async => await _player.seek(position);

  static Stream<Duration> get positionStream => _player.onPositionChanged;
  static Stream<Duration> get durationStream => _player.onDurationChanged;
}