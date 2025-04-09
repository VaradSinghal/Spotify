class Playlist {
    constructor(id, name, userId, songs = []) {
      this.id = id;
      this.name = name;
      this.userId = userId;
      this.songs = songs;
    }
  }
  
  module.exports = Playlist;