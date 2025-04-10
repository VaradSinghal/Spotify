import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/models/playlist.dart';
import 'package:spotify/widgets/song_tile.dart';
import '../providers/music_provider.dart';


class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library')),
      body: Consumer<MusicProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.playlists.length,
          itemBuilder: (context, index) {
            final playlist = provider.playlists[index];
            return ListTile(
              title: Text(playlist.name),
              subtitle: Text('${playlist.songs.length} songs'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PlaylistScreen(playlist: playlist)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  PlaylistScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(playlist.name)),
      body: ListView.builder(
        itemCount: playlist.songs.length,
        itemBuilder: (context, index) => SongTile(song: playlist.songs[index]),
      ),
    );
  }
}