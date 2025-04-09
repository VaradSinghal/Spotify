const { db } = require('../firebase');

exports.getSongs = async (req, res) => {
  try {
    const snapshot = await db.collection('songs').get();
    const songs = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.json(songs);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.searchSongs = async (req, res) => {
  try {
    const { query } = req.query;
    const snapshot = await db.collection('songs')
      .where('title', '>=', query)
      .where('title', '<=', query + '\uf8ff')
      .get();
    const songs = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.json(songs);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};