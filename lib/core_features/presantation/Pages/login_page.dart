import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/auth_service.dart';
import 'package:student_manegment_app/core_features/presantation/Components/login_text_field.dart';
import 'package:student_manegment_app/core_features/presantation/Components/my_btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();

  // texteditingcontollers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //sign in
  void signIn() async {
    authService.signIn(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icon TODO : add app icon
            const Icon(
              Icons.lock,
              color: Colors.black,
              size: 72,
            ),
            const SizedBox(
              height: 20,
            ),

            // Email
            // LoginTextField
            LoginTextField(
              hintText: "Email",
              isObsText: false,
              controller: emailController,
            ),

            const SizedBox(
              height: 10,
            ),

            // password
            LoginTextField(
              hintText: "Password",
              isObsText: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            // login button
            MyBtn(
              onTap: signIn,
            ),
          ],
        ),
      ),
    );
  }
}
