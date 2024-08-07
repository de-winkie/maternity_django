// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maternity/constant.dart';
import 'dart:convert';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ScheduleDetails extends StatefulWidget {
  final int scheduleId;
  const ScheduleDetails({Key? key, required this.scheduleId}) : super(key: key);

  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
  String scheduleName = 'Loading...';
  String scheduleImage = 'assets/images/munira.jpg'; 
  List<dynamic> treatments = [];
  String todayDate = '';

  @override
  void initState() {
    super.initState();
    fetchScheduleDetails();
    todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Format today's date
  }

  Future<void> fetchScheduleDetails() async {
    final scheduleResponse = await http.get(Uri.parse('$api/schedule/schedule-detail/${widget.scheduleId}/'));
    if (scheduleResponse.statusCode == 200) {
      final scheduleData = json.decode(scheduleResponse.body);
      setState(() {
        scheduleName = scheduleData['scheduleName'] ?? 'No Name';
        scheduleImage = scheduleData['image'] ?? scheduleImage;
      });
    }

    // Fetch treatments
    final treatmentsResponse = await http.get(Uri.parse('$api/treatment/treatment-by-schedule/${widget.scheduleId}/'));
    if (treatmentsResponse.statusCode == 200) {
      final treatmentsData = json.decode(treatmentsResponse.body);
      setState(() {
        treatments = treatmentsData;
      });
    }
  }

  Future<void> printReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Schedule Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Text('Schedule Name: $scheduleName', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Date: $todayDate', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 16),
            pw.Text('Treatments:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...treatments.map((treatment) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Test Name: ${treatment['testName']}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Amount: ${treatment['amount']}', style: pw.TextStyle(fontSize: 14)),
                    pw.Text('Diagnosis: ${treatment['diagnosis']}', style: pw.TextStyle(fontSize: 14)),
                    pw.Text('Description: ${treatment['description']}', style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      print('Error printing report: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scheduleName),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: printReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.h),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(1.h),
                      topRight: Radius.circular(1.h),
                    ),
                    child: Image.asset(
                      scheduleImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.6.h),
                    child: Text(
                      'Today is: $todayDate',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            ...treatments.map((treatment) => ExpansionTile(
              title: Text(
                treatment['testName'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount: ${treatment['amount']}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Diagnosis: ${treatment['diagnosis']}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Description: ${treatment['description']}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )).toList(),
          ],
        ),
      ),
    );
  }
}
