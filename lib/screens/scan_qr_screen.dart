import 'package:attendify/services/add_attendance.dart';
import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:attendify/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQrScreen extends StatefulWidget {
  int day;
  int month;

  ScanQrScreen({super.key, required this.day, required this.month});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
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
                  text: 'Scan',
                  fontSize: 16,
                  fontFamily: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  scanQRCode();
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: hasScanned
                      ? QrImageView(
                          data: studentId,
                          version: QrVersions.auto,
                          size: 300.0,
                        )
                      : Center(
                          child: TextWidget(
                            text: 'SCAN\nQR HERE',
                            fontSize: 24,
                            fontFamily: 'Medium',
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            hasScanned
                ? TextWidget(
                    text: 'Student: $studentName',
                    fontSize: 18,
                    fontFamily: 'Medium',
                  )
                : SizedBox(),
            SizedBox(
              height: 50,
            ),
            hasScanned
                ? Center(
                    child: ButtonWidget(
                      label: 'Tardy',
                      onPressed: () {
                        addAttendance(studentName, 'Tardy', studentId)
                            .whenComplete(
                          () {
                            Navigator.pop(context);
                            showToast('Attendance added!');
                          },
                        );

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => ScanQrScreen()));
                      },
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            hasScanned
                ? Center(
                    child: ButtonWidget(
                      label: 'Not Tardy',
                      onPressed: () {
                        addAttendance(studentName, 'Not Tardy', studentId)
                            .whenComplete(
                          () {
                            Navigator.pop(context);
                            showToast('Attendance added!');
                          },
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      )),
    );
  }

  String studentId = '';
  String studentName = '';
  String qrCode = 'Unknown';
  bool hasScanned = false;

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });

      if (qrCode != '-1') {
        FirebaseFirestore.instance
            .collection('Students')
            .where('studentId', isEqualTo: qrCode)
            .get()
            .then(
          (value) {
            if (value.docs.isNotEmpty) {
              setState(() {
                studentId = value.docs.first.id;
                studentName = value.docs.first['name'];
                hasScanned = true;
              });
            } else {
              showToast('Student to not exist with that qr code!');
            }
          },
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
