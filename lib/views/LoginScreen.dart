// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/views/homeScreen.dart';
import 'package:flutter_application_firebase/views/signUpScreen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// import 'dart:html';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("login"),
        // actions: const
        // [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 250.0,
              child: Lottie.asset("assets/53395-login.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: loginEmailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: loginPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPasword = loginPasswordController.text.trim();
                  try {
                    final User? FirebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginEmail, password: loginPasword))
                        .user;

                    if (FirebaseUser != null) {
                      Get.to(() => const HomeScreen());
                    } else {
                      print("check Email and Password");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                },
                child: const Text('Login')),
                
            GestureDetector(
              onTap: () {
                Get.to(() => const SignUpScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Text("Don't have account SingUp"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
