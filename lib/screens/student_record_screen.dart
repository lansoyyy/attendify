import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentRecordScreen extends StatelessWidget {
  int day;
  int month;

  StudentRecordScreen({super.key, required this.day, required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 35,
                ),
                TextWidget(
                  text: 'Records',
                  fontSize: 16,
                  fontFamily: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                TextWidget(
                  text: DateFormat('dd/MM/yyy')
                      .format(DateTime(2025, month, day)),
                  fontSize: 24,
                  fontFamily: 'Bold',
                ),
                Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                ButtonWidget(
                  fontSize: 12,
                  width: 150,
                  height: 40,
                  label: 'Export CSV',
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'List of Students',
                  fontSize: 22,
                  fontFamily: 'Bold',
                ),
                TextWidget(
                  text: 'Remarks',
                  fontSize: 22,
                  fontFamily: 'Bold',
                ),
              ],
            ),
            Divider(),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Attendance')
                    .where('year', isEqualTo: DateTime.now().year)
                    .where('month', isEqualTo: month)
                    .where('day', isEqualTo: day)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('Error'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }

                  final data = snapshot.requireData;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 40,
                          child: ListTile(
                            leading: TextWidget(
                              text: data.docs[index]['name'],
                              fontSize: 22,
                              fontFamily: 'Medium',
                            ),
                            trailing: TextWidget(
                              text: data.docs[index]['remarks'],
                              fontSize: 22,
                              fontFamily: 'Medium',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
