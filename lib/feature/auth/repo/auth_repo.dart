import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/cache_helper/cache_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp({
    required String userName,

    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(userName);
      await result.user!.reload();
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseAuthError(e));
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CacheHelper.saveData(key: CacheKeys.userId, value: result.user!.uid);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseAuthError(e));
    }
  }



//  Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      print("object");
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // المستخدم لغى العملية

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }


  /// Logout
  Future<void> logout() async {
    
    await _auth.signOut();
    ();
  }

  Stream<User?> get userStream => _auth.authStateChanges();

  /// Helper: FirebaseAuthException messages
  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      default:
        return 'Something went wrong: ${e.message}';
    }
  }
}
