import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List students = [];
  CollectionReference collectionReferenceStudents = db.collection('students');
  QuerySnapshot queryStudents = await collectionReferenceStudents.get();
  queryStudents.docs.forEach((documento) {
    students.add(documento.data());
  });

  return students;
}
