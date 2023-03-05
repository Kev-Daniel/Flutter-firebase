// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/views/homeScreen.dart';
import 'package:get/get.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  TextEditingController CreateController = TextEditingController();
  TextEditingController PrecioController = TextEditingController();
  TextEditingController MarcaController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
      ),
      body: Container(
        child: Column(children: [
          Container(
            child: TextFormField(
              controller: CreateController,
              decoration:
                  const InputDecoration(hintText: "Nombre del producto"),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            child: TextFormField(
              controller: PrecioController,
              decoration: const InputDecoration(hintText: "Precio"),
            ),
          ),
          Container(
            child: TextFormField(
              controller: MarcaController,
              decoration: const InputDecoration(hintText: "Marca"),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () async {
                var product = CreateController.text.trim();
                var price = PrecioController.text.trim();
                var marca = MarcaController.text.trim();
                if (product != "") {
                  try {
                    await FirebaseFirestore.instance
                        .collection("Products")
                        .doc()
                        .set({
                      "product": product,
                      "precio": price,
                      "marca": marca,
                      "userId": userId?.uid,
                    }).then((value) => {
                              Get.offAll(() => const HomeScreen()),
                            });
                  } catch (e) {
                    print("Error $e");
                  }
                }
              },
              child: const Text("Guardar"))
        ]),
      ),
    );
  }
}
