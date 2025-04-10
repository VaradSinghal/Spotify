import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';
import '../models/playlist.dart';

class ApiService {
  static const String _baseUrl = '';

  Future<List<Song>> getSongs() async {
    final response = await http.get(Uri.parse('$_baseUrl/songs'));
    return (jsonDecode(response.body) as List).map((s) => Song.fromJson(s)).toList();
  }

  Future<List<Song>> searchSongs(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/songs/search?query=$query'));
    return (jsonDecode(response.body) as List).map((s) => Song.fromJson(s)).toList();
  }

  Future<List<Playlist>> getPlaylists(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/playlists?userId=$userId'));
    return (jsonDecode(response.body) as List).map((p) => Playlist.fromJson(p)).toList();
  }

  Future<void> createPlaylist(String name, String userId) async {
    await http.post(
      Uri.parse('$_baseUrl/playlists'),
      body: jsonEncode({'name': name, 'userId': userId}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> addSongToPlaylist(String playlistId, Song song) async {
    await http.post(
      Uri.parse('$_baseUrl/playlists/addSong'),
      body: jsonEncode({'playlistId': playlistId, 'song': song.toJson()}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}