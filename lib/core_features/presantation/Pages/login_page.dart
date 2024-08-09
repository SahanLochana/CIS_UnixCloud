import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/auth_service.dart';
import 'package:student_manegment_app/core_features/presantation/Components/loading_wave.dart';
import 'package:student_manegment_app/core_features/presantation/Components/login_text_field.dart';
import 'package:student_manegment_app/core_features/presantation/Components/msg_tile.dart';
import 'package:student_manegment_app/core_features/presantation/Components/my_btn.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  int errorCode = 0;
  bool isTrying = false;
  bool isTimeUp = false;

  // texteditingcontollers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //sign in
  void signIn() async {
    setState(() {
      isTrying = true;
    });
    int state = await authService
        .signIn(emailController.text, passwordController.text)
        .timeout(
      Duration(seconds: 5),
      onTimeout: () {
        setState(() {
          isTrying = false;
        });
        return 4;
      },
    );
    setState(() {
      errorCode = state;
    });
    if (errorCode > 0) {
      setState(() {
        isTrying = false;
      });
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
              if (errorCode > 0)
                ErrorMsgTile(
                  errorCode: errorCode,
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
                isTrying: isTrying,
                onTap: signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
