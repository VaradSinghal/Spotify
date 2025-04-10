class Song {
  final String id;
  final String title;
  final String artist;
  final String url;
  final String? artwork;

  Song({required this.id, required this.title, required this.artist, required this.url, this.artwork});

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    id: json['id'],
    title: json['title'],
    artist: json['artist'],
    url: json['url'],
    artwork: json['artwork'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'artist': artist,
    'url': url,
    'artwork': artwork,
  };
}