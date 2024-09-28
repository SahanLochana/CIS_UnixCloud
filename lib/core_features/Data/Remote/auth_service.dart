import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // continuesly listn to user login state
  Stream<User?> checkAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // user signIn
  Future<int> signIn(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return 1;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-credential":
          return 2;
        case "network-request-failed":
          return 3;
        default:
          return 4;
      }
    } catch (e) {
      return 6;
    }
  }
}
