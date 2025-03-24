import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addStudent(name, gender) async {
  final docUser = FirebaseFirestore.instance.collection('Students').doc();

  final json = {
    'name': name,
    'dateTime': DateTime.now(),
    'studentId': docUser.id,
    'status': ''
  };

  await docUser.set(json);

  return docUser.id;
}
