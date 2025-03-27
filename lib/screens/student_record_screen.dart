import 'package:attendify/widgets/button_widget.dart';
import 'package:attendify/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StudentRecordScreen extends StatefulWidget {
  int day;
  int month;

  StudentRecordScreen({super.key, required this.day, required this.month});

  @override
  State<StudentRecordScreen> createState() => _StudentRecordScreenState();
}

class _StudentRecordScreenState extends State<StudentRecordScreen> {
  List reports = [];
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
                      .format(DateTime(2025, widget.month, widget.day)),
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
                  width: 125,
                  height: 40,
                  label: 'Export',
                  onPressed: () {
                    generatePdf(reports);
                  },
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
                    .where('month', isEqualTo: widget.month)
                    .where('day', isEqualTo: widget.day)
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
                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            reports.clear();
                            reports.add({
                              'remarks': data.docs[index]['remarks'],
                              'name': data.docs[index]['name'],
                            });
                          },
                        );
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

  void generatePdf(List tableDataList) async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.fullscreen,
    );
    List<String> tableHeaders = [
      'Number',
      'Name',
      'Remarks',
    ];

    String cdate2 = DateFormat("MMMM dd, yyyy")
        .format(DateTime(DateTime.now().year, widget.month, widget.day));

    List<List<String>> tableData = [];
    for (var i = 0; i < tableDataList.length; i++) {
      tableData.add([
        '${i + 1}',
        tableDataList[i]['name'],
        tableDataList[i]['remarks'],
      ]);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a3,
        orientation: pw.PageOrientation.landscape,
        build: (context) => [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Attendify',
                    style: const pw.TextStyle(
                      fontSize: 18,
                    )),
                pw.SizedBox(height: 10),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                  'Attendance for',
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                  cdate2,
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            headerDecoration: const pw.BoxDecoration(),
            rowDecoration: const pw.BoxDecoration(),
            headerHeight: 25,
            cellHeight: 45,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
            },
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    final Uint8List pdfBytes = await pdf.save();

// Share the PDF using the Printing package
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'attendance.pdf',
    );

// // Optional: Handle the PDF bytes for web
//     if (kIsWeb) {
//       final blob = html.Blob([pdfBytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);
//       final anchor = html.AnchorElement(href: url)
//         ..target = 'blank'
//         ..download = 'report.pdf'
//         ..click();
//       html.Url.revokeObjectUrl(url);
//     }
  }
}
