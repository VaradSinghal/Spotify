const functions = require('firebase-functions');
const express = require('express');
const cors = require('cors');
const auth = require('./controllers/auth');
const songs = require('./controllers/songs');
const playlists = require('./controllers/playlists');

const app = express();
app.use(cors({ origin: true }));

app.post('/login', auth.login);
app.post('/register', auth.register);
app.get('/songs', songs.getSongs);
app.get('/songs/search', songs.searchSongs);
app.get('/playlists', playlists.getPlaylists);
app.post('/playlists', playlists.createPlaylist);
app.post('/playlists/addSong', playlists.addSongToPlaylist);

exports.api = functions.https.onRequest(app);