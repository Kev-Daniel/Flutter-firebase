// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, avoid_print, unused_local_variable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_firebase/views/homeScreen.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController EditMarcaController = TextEditingController();
  TextEditingController EditNameProductController = TextEditingController();
  TextEditingController EditPriceController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments['product'].toString(),
        ),
      ),
      body: Container(
        child: Column(children: [
          Container(
            child: TextFormField(
              controller: EditNameProductController
                ..text = "${Get.arguments['product'].toString()}",
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Container(
            child: TextFormField(
              controller: EditPriceController
                ..text = "${Get.arguments['precio'].toString()}",
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Container(
            child: TextFormField(
              controller: EditMarcaController
                ..text = "${Get.arguments['marca'].toString()}",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var IdProduct = Get.arguments['docId'].toString();
              var EditProduct = EditNameProductController.text.trim();
              var EditPrice = EditPriceController.text.trim();
              var EditMarca = EditMarcaController.text.trim();
              var example = "hola";
              await FirebaseFirestore.instance
                  .collection("Products")
                  .doc()
                  .set({
                    "product": EditProduct,
                    "precio": EditPrice,
                    "marca": EditMarca,
                    "userId": userId?.uid,
                  })
                  .then((value) => {
                        print("User Updated"),
                      })
                  .catchError(
                      (error) => print("Failed to update user: $error"));
              await FirebaseFirestore.instance
                  .collection("Products")
                  .doc(IdProduct)
                  .delete()
                  .then((value) => {
                        Get.offAll(() => const HomeScreen()),
                        print("Actualizado 12"),
                      })
                  .catchError(
                      (error) => print("Failed to update user: $error"));
            },
            child: const Text("Actualizar"),
          )
        ]),
      ),
    );
  }
}
