import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/auth_service.dart';
import 'package:student_manegment_app/core_features/presantation/Components/login_text_field.dart';
import 'package:student_manegment_app/core_features/presantation/Components/msg_tile.dart';
import 'package:student_manegment_app/core_features/presantation/Components/my_btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  bool wrongCred = false;

  // texteditingcontollers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //sign in
  void signIn() async {
    int state =
        await authService.signIn(emailController.text, passwordController.text);
    if (state == 2) {
      setState(() {
        wrongCred = true;
      });
      emailController.clear();
      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                height: 150,
                width: 150,
                child: Center(
                  child: Image.asset(
                    "assets/logo.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (wrongCred)
                const ErrorMsgTile(
                  errorMSg: "Check your email/password",
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
      ),
    );
  }
}
