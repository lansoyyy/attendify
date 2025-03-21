import 'package:attendify/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class StudentRecordScreen extends StatelessWidget {
  const StudentRecordScreen({super.key});

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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40,
                    child: ListTile(
                      leading: TextWidget(
                        text: 'Juan Dela Cruz',
                        fontSize: 22,
                        fontFamily: 'Medium',
                      ),
                      trailing: TextWidget(
                        text: 'Tardy',
                        fontSize: 22,
                        fontFamily: 'Medium',
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
