import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../services/audio_service.dart';
import '../providers/music_provider.dart';
import '../screens/player_screen.dart';

class SongTile extends StatelessWidget {
  final Song song;

  SongTile({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: song.artwork != null ? CachedNetworkImage(imageUrl: song.artwork!) : Icon(Icons.music_note),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'Add to Playlist') {
            _showPlaylistDialog(context, song);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 'Add to Playlist', child: Text('Add to Playlist')),
        ],
      ),
      onTap: () {
        Provider.of<MusicProvider>(context, listen: false).setCurrentSong(song);
        AudioService.play(song);
        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayerScreen()));
      },
    );
  }

  void _showPlaylistDialog(BuildContext context, Song song) {
    final provider = Provider.of<MusicProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add to Playlist'),
        content: Container(
          width: double.minPositive,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: provider.playlists.length,
            itemBuilder: (context, index) {
              final playlist = provider.playlists[index];
              return ListTile(
                title: Text(playlist.name),
                onTap: () {
                  provider.addSongToPlaylist(playlist.id, song);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}