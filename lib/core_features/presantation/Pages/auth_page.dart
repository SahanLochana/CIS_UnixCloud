import 'package:CIS_UnixCloud/core_features/Data/Remote/auth_service.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/home_page.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authService.checkAuthState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // user logged -> show homepage
          if (snapshot.hasData) {
            return const HomePage();
          }
          // user not logged -> show login page
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
