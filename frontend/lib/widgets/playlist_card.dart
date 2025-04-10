import 'package:flutter/material.dart';
import '../models/playlist.dart';
import '../screens/library_screen.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  PlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlaylistScreen(playlist: playlist))),
      child: Card(
        color: Colors.grey[800],
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(height: 100, color: Colors.grey[700]), // Placeholder for artwork
              Padding(padding: EdgeInsets.all(8), child: Text(playlist.name)),
            ],
          ),
        ),
      ),
    );
  }
}