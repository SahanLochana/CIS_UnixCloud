import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // continuesly listn to user login state
  Stream<User?> checkAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // user signIn
  void signIn(String emailAddress, String password) async {
    //TODO : try catch
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        // print('plz check your email & password!');
      } else {
        // print('error : ${e.code}.');
      }
    }
  }
}
