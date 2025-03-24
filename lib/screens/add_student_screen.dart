import 'package:attendify/screens/generate_qr_screen.dart';
import 'package:attendify/screens/student_list_screen.dart';
import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:attendify/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final name = TextEditingController();
  bool isMale = true;
  bool isFemale = false;

  void _updateSelection(String gender) {
    setState(() {
      if (gender == 'Male') {
        isMale = true;
        isFemale = false;
      } else {
        isMale = false;
        isFemale = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                    text: 'Add Student',
                    fontSize: 16,
                    fontFamily: 'Medium',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Name',
                controller: name,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: CheckboxListTile(
                      title: Text('Male'),
                      value: isMale,
                      onChanged: (value) => _updateSelection('Male'),
                    ),
                  ),
                  SizedBox(
                    width: 175,
                    height: 35,
                    child: CheckboxListTile(
                      title: Text('Female'),
                      value: isFemale,
                      onChanged: (value) => _updateSelection('Female'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: ButtonWidget(
                  label: 'Add Student',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GenerateQrScreen()));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ButtonWidget(
                  label: 'See Student List',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentListScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
