import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/widgets/song_tile.dart';
import '../providers/music_provider.dart';
import '../widgets/playlist_card.dart';
import 'search_screen.dart';
import 'library_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MusicProvider>(context, listen: false);
    provider.fetchSongs();
    provider.fetchPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Consumer<MusicProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Your Songs', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.songs.length,
                itemBuilder: (context, index) => SongTile(song: provider.songs[index]),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Playlists', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.playlists.length + 1,
                  itemBuilder: (context, index) {
                    if (index == provider.playlists.length) {
                      return GestureDetector(
                        onTap: () async {
                          final name = await _showCreatePlaylistDialog(context);
                          if (name != null) provider.createPlaylist(name);
                        },
                        child: Card(
                          color: Colors.grey[800],
                          child: SizedBox(width: 150, child: Center(child: Text('+ New Playlist'))),
                        ),
                      );
                    }
                    return PlaylistCard(playlist: provider.playlists[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
        ],
        onTap: (index) {
          switch (index) {
            case 0: break;
            case 1: Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())); break;
            case 2: Navigator.push(context, MaterialPageRoute(builder: (_) => LibraryScreen())); break;
          }
        },
      ),
    );
  }

  Future<String?> _showCreatePlaylistDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Playlist'),
        content: TextField(controller: controller, decoration: InputDecoration(hintText: 'Playlist Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text('Create')),
        ],
      ),
    );
  }
}