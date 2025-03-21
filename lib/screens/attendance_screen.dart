import 'package:attendify/screens/calendar_screen.dart';
import 'package:attendify/utils/colors.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<String> months = ['January'];
  List<String> allMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void addMonth() {
    if (months.length < allMonths.length) {
      setState(() {
        months.add(allMonths[months.length]);
      });
    }
  }

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
                  text: 'Take Attendance',
                  fontSize: 16,
                  fontFamily: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: months.map((month) => _buildMonthCard(month)).toList()
                ..add(_buildAddButton()),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildMonthCard(String month) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CalendarScreen()));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            month,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Bold'),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: addMonth,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Month',
                style: TextStyle(
                    color: Colors.black, fontSize: 14, fontFamily: 'Bold'),
              ),
              Text(
                '+',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
