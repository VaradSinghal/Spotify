import 'package:flutter/material.dart';
import '../models/song.dart';
import '../models/playlist.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class MusicProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();
  List<Song> _songs = [];
  List<Playlist> _playlists = [];
  Song? _currentSong;

  List<Song> get songs => _songs;
  List<Playlist> get playlists => _playlists;
  Song? get currentSong => _currentSong;

  Future<void> fetchSongs() async {
    _songs = await _api.getSongs();
    notifyListeners();
  }

  Future<void> fetchPlaylists() async {
    final user = await _auth.getCurrentUser();
    if (user != null) {
      _playlists = await _api.getPlaylists(user.id);
      notifyListeners();
    }
  }

  Future<void> createPlaylist(String name) async {
    final user = await _auth.getCurrentUser();
    if (user != null) {
      await _api.createPlaylist(name, user.id);
      await fetchPlaylists();
    }
  }

  Future<void> addSongToPlaylist(String playlistId, Song song) async {
    await _api.addSongToPlaylist(playlistId, song);
    await fetchPlaylists();
  }

  Future<List<Song>> searchSongs(String query) async {
    return await _api.searchSongs(query);
  }

  void setCurrentSong(Song song) {
    _currentSong = song;
    notifyListeners();
  }
}