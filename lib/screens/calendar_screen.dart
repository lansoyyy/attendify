import 'package:attendify/screens/scan_qr_screen.dart';
import 'package:attendify/screens/student_record_screen.dart';
import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                    text: 'January',
                    fontSize: 16,
                    fontFamily: 'Medium',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                text: 'January',
                fontSize: 24,
                fontFamily: 'Bold',
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                text: 'Present',
                fontSize: 14,
                fontFamily: 'Medium',
              ),
              TextWidget(
                text: 'Number of Present',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Absent',
                fontSize: 14,
                fontFamily: 'Medium',
              ),
              TextWidget(
                text: 'Number of Absent',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Tardy',
                fontSize: 14,
                fontFamily: 'Medium',
              ),
              TextWidget(
                text: 'Number of Tardy',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  label: 'Scan',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScanQrScreen()));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ButtonWidget(
                  label: 'See Record',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentRecordScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
