import 'package:attendify/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

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
                SizedBox(
                  width: 20,
                ),
                TextWidget(
                  text: 'Student List',
                  fontSize: 16,
                  fontFamily: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            TextWidget(
              text: 'List of Students',
              fontSize: 22,
              fontFamily: 'Bold',
            ),
            Divider(),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Students')
                    .orderBy('dateTime', descending: true)
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
