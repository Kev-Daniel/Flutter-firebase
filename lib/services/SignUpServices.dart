// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_firebase/views/LoginScreen.dart';
import 'package:get/get.dart';

signUpUser(String userName, String userPhone, String userEmail,
    String userPassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'UserId': userid.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(()=>const LoginScreen())
    });
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
