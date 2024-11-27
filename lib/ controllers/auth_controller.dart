import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign Up Method
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user profile with the name
      await userCredential.user?.updateDisplayName(name);
      return true;
    } catch (e) {
      print('Error during signup: $e');
      return false;
    }
  }

  // Sign In Method
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Error during signin: $e');
      return false;
    }
  }

  // Sign Out Method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
