import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // continuesly listn to user login state
  Stream<User?> checkAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // user signIn
  void signIn(String emailAddress, String password) async {
    //TODO : try catch
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }
}
