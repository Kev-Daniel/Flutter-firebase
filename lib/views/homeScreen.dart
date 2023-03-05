// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/views/EditProductScreen.dart';
import 'package:flutter_application_firebase/views/createproduct.dart';
import 'package:get/get.dart';
import 'package:flutter_application_firebase/views/LoginScreen.dart';
import 'package:flutter_application_firebase/views/LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => const LoginScreen());
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .where("userId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Ocurrio un error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data!.docs[index]['product'];
                  var precio = snapshot.data!.docs[index]['precio'];
                  var marca = snapshot.data!.docs[index]['marca'];
                  var docId = snapshot.data!.docs[index].id;

                  return Card(
                    child: ListTile(
                      title: Text(
                        product,
                      ),
                      subtitle: Text('Precio: ' + precio),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const EditProductScreen(),
                              arguments: {
                                'product': product,
                                'precio': precio,
                                'marca': marca,
                                'docId': docId,
                              },
                            );
                          },
                          child: const Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection("Products")
                                .doc(docId)
                                .delete()
                                .then((value) => docId);
                            // .then((value) => {
                            //       print("Eliminado"),
                            //     })
                            // .catchError((error) =>
                            //     print("Failed to update user: $error"));
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ]),
                    ),
                  );
                },
              );
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data!.docs[index]['product'];
                  var precio = snapshot.data!.docs[index]['precio'];
                  var marca = snapshot.data!.docs[index]['marca'];
                  var docId = snapshot.data!.docs[index].id;

                  return Card(
                    child: ListTile(
                      title: Text(
                        product,
                      ),
                      subtitle: Text('Precio: ' + precio),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const EditProductScreen(),
                              arguments: {
                                'product': product,
                                'precio': precio,
                                'marca': marca,
                                'docId': docId,
                              },
                            );
                          },
                          child: const Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection("Products")
                                .doc(docId)
                                .delete()
                                .then((value) => docId);
                            // .then((value) => {
                            //       print("Eliminado"),
                            //     })
                            // .catchError((error) =>
                            //     print("Failed to update user: $error"));
                          },
                          child: const Icon(Icons.delete),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Eliminar"))
                      ]),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const CreateProductScreen());
          },
          child: const Icon(Icons.add)),
    );
  }
}
