import 'package:demo/ui/buttons.dart';
import 'package:demo/ui/text_c.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();

  final _password = TextEditingController();

  void tapped() async {
    final email = _username.text.trim();
    final password = _password.text;

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    final passwordRegex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$");

    if (!emailRegex.hasMatch(email)) {
      message("Enter a valid email address");
      return;
    }

    if (!passwordRegex.hasMatch(password)) {
      message("Password must be at least 6 characters and contain letters and numbers");
      return;
    }


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context); 
    } on FirebaseException catch (e) {
      Navigator.pop(context); 
      if (e.code == 'invalid-email') {
        message("Wrong username");
      } else if (e.code == 'invalid-credential') {
        message("Wrong password");
      } else {
        message("Authentication failed: ${e.message}");
      }
    }
  }

  void message(String data) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(data),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 247, 194),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Icon(
                Icons.lock,
                size: 60,
                color: Colors.amber.shade900,
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyText(hintText: "Email",obscureText: false,controller: _username,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyText(hintText: "Password",obscureText: true,controller: _password,),
              ),
              SizedBox(height: 20,),
              Buttons(ontap: tapped, data: "Sign in"),
              SizedBox(height: 20,),
              
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()
                ),
                child: Image.asset(
                  "assets/images/google_logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}