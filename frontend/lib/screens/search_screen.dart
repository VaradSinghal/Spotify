import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/models/song.dart';
import 'package:spotify/widgets/song_tile.dart';
import '../providers/music_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Song> _results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search songs...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final provider = Provider.of<MusicProvider>(context, listen: false);
                    _results = await provider.searchSongs(_controller.text);
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) => SongTile(song: _results[index]),
            ),
          ),
        ],
      ),
    );
  }
}