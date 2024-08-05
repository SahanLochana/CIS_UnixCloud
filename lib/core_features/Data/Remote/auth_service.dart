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
      if (e.code == "invalid-credential") {
        return 2;
        // throw 'plz check your email & password!';
      } else {
        return 3;
        // throw "${e.code}";
      }
    }
  }
}
