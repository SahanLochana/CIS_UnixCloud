import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/auth_service.dart';
import 'package:student_manegment_app/core_features/presantation/Pages/home_page.dart';
import 'package:student_manegment_app/core_features/presantation/Pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authService.checkAuthState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // user logged
          if (snapshot.hasData) {
            return const HomePage();
          }
          // user not logged
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
