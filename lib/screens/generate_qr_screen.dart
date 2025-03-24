import 'package:attendify/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrScreen extends StatelessWidget {
  dynamic data;

  GenerateQrScreen({super.key, required this.data});

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
                    text: 'Add Student',
                    fontSize: 16,
                    fontFamily: 'Medium',
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextWidget(
                text: data['name'],
                fontSize: 24,
                fontFamily: 'Bold',
              ),
              TextWidget(
                text: data['gender'],
                fontSize: 16,
                fontFamily: 'Medium',
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: QrImageView(
                    data: data['id'],
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
