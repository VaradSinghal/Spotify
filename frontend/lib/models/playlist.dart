import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String userId;
  final List<Song> songs;

  Playlist({required this.id, required this.name, required this.userId, required this.songs});

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
    id: json['id'],
    name: json['name'],
    userId: json['userId'],
    songs: (json['songs'] as List).map((s) => Song.fromJson(s)).toList(),
  );
}