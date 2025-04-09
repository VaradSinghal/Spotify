const { db } = require('../firebase');

exports.getPlaylists = async (req, res) => {
  try {
    const { userId } = req.query;
    const snapshot = await db.collection('playlists')
      .where('userId', '==', userId)
      .get();
    const playlists = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.json(playlists);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createPlaylist = async (req, res) => {
  try {
    const { name, userId } = req.body;
    const ref = await db.collection('playlists').add({
      name,
      userId,
      songs: [],
      createdAt: new Date().toISOString()
    });
    res.json({ id: ref.id, name, userId, songs: [] });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.addSongToPlaylist = async (req, res) => {
  try {
    const { playlistId, song } = req.body;
    await db.collection('playlists').doc(playlistId).update({
      songs: admin.firestore.FieldValue.arrayUnion(song)
    });
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};