class Song {
    constructor(id, title, artist, url, artwork) {
      this.id = id;
      this.title = title;
      this.artist = artist;
      this.url = url;
      this.artwork = artwork || null;
    }
  }
  
  module.exports = Song;