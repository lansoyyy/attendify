import 'package:attendify/screens/add_student_screen.dart';
import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              text: 'Attendify',
              fontSize: 28,
              fontFamily: 'Bold',
            ),
            SizedBox(
              height: 50,
            ),
            ButtonWidget(
              label: 'Add Student',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddStudentScreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
              label: 'Take Attendance',
              onPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
              label: 'Export CSV',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
