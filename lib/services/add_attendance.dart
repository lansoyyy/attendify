import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addAttendance(name, remarks, studentId) async {
  final docUser = FirebaseFirestore.instance
      .collection('Attendance')
      .doc(DateTime.now().toString());

  final json = {
    'name': name,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'studentId': studentId,
    'remarks': remarks,
    'year': DateTime.now().year,
    'month': DateTime.now().month,
    'day': DateTime.now().day,
  };

  await docUser.set(json);

  return docUser.id;
}
