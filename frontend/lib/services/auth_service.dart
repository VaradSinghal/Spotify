import 'package:firebase_auth/firebase_auth.dart' as fa;
import '../models/user.dart'; // AppUser
// If PigeonUserDetails is generated, import it (e.g., from firebase_auth's generated files)
// import 'package:firebase_auth_platform_interface/pigeon.dart' if it exists

class AuthService {
  final _auth = fa.FirebaseAuth.instance;

  Future<fa.User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user; // Returns Firebase User
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<fa.User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    return firebaseUser != null ? AppUser(id: firebaseUser.uid, email: firebaseUser.email ?? '') : null;
  }

  Future<bool> isLoggedIn() async => _auth.currentUser != null;
}