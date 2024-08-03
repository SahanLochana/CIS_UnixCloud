import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Stream<User?> checkAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  void signIn(String emailAddress, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }
}
