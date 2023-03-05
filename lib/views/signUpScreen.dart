import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/SignUpServices.dart';
// import 'dart:html';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Acount"),
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
                controller: userNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Name',
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
                controller: userPhoneController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Phone',
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
                controller: userEmailController,
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
                controller: userPasswordController,
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
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();

                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {
                            log("User Created"),
                            signUpUser(
                              userName,
                              userPhone,
                              userEmail,
                              userPassword,                   
                            ),
                          });
                },
                child: const Text('Create Account')),
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Text("Already have an account SignIn"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
