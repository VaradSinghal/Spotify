const { db, admin } = require('../firebase');

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await admin.auth().getUserByEmail(email);
   
    const token = await admin.auth().createCustomToken(user.uid);
    res.json({ token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.register = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await admin.auth().createUser({ email, password });
    res.json({ id: user.uid, email: user.email });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};