import 'package:attendify/screens/scan_qr_screen.dart';
import 'package:attendify/screens/student_record_screen.dart';
import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  int month;

  CalendarScreen({super.key, required this.month});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int day = 1;
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
                text: DateFormat('dd/MM/yyy')
                    .format(DateTime(2025, widget.month, day)),
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
                  child: MonthView(
                    onCellTap: (events, date) {
                      setState(() {
                        day = date.day;
                      });
                    },
                    initialMonth: DateTime(2025, widget.month),
                  ),
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Attendance')
                      .where('year', isEqualTo: DateTime.now().year)
                      .where('month', isEqualTo: widget.month)
                      .where('day', isEqualTo: day)
                      .where('remarks', isEqualTo: 'Not Tardy')
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
                    return TextWidget(
                      text: data.docs.length.toString(),
                      fontSize: 18,
                      fontFamily: 'Bold',
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Absent',
                fontSize: 14,
                fontFamily: 'Medium',
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Students')
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

                    final studentData = snapshot.requireData;
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Attendance')
                            .where('year', isEqualTo: DateTime.now().year)
                            .where('month', isEqualTo: widget.month)
                            .where('day', isEqualTo: day)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(child: Text('Error'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }

                          final attendanceData = snapshot.requireData;
                          return TextWidget(
                            text: (studentData.docs.length -
                                    attendanceData.docs.length)
                                .toString(),
                            fontSize: 18,
                            fontFamily: 'Bold',
                          );
                        });
                  }),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Tardy',
                fontSize: 14,
                fontFamily: 'Medium',
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Attendance')
                      .where('year', isEqualTo: DateTime.now().year)
                      .where('month', isEqualTo: widget.month)
                      .where('day', isEqualTo: day)
                      .where('remarks', isEqualTo: 'Tardy')
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
                    return TextWidget(
                      text: data.docs.length.toString(),
                      fontSize: 18,
                      fontFamily: 'Bold',
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  label: 'Scan',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScanQrScreen(
                              day: day,
                            )));
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
                        builder: (context) => StudentRecordScreen(
                              day: day,
                              month: widget.month,
                            )));
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
