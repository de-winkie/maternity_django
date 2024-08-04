import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maternity/constant.dart';
import 'dart:convert';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScheduleDetails extends StatefulWidget {
  final int scheduleId;
  const ScheduleDetails({Key? key, required this.scheduleId}) : super(key: key);

  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
  String scheduleName = 'Loading...';
  String scheduleImage = 'assets/images/munira.jpg'; // Placeholder image
  List<dynamic> treatments = [];

  @override
  void initState() {
    super.initState();
    fetchScheduleDetails();
  }

  Future<void> fetchScheduleDetails() async {
    // Fetch schedule details
    final scheduleResponse = await http.get(Uri.parse('$api/treatment/treatment-by-schedule/${widget.scheduleId}/'));
    if (scheduleResponse.statusCode == 200) {
      final scheduleData = json.decode(scheduleResponse.body);
      setState(() {
        scheduleName = scheduleData['name'] ?? 'No Name';
        scheduleImage = scheduleData['image'] ?? scheduleImage;
      });
    }

    // Fetch treatments
    final treatmentsResponse = await http.get(Uri.parse('http://your-api-url/treatments?scheduleId=${widget.scheduleId}'));
    if (treatmentsResponse.statusCode == 200) {
      final treatmentsData = json.decode(treatmentsResponse.body);
      setState(() {
        treatments = treatmentsData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scheduleName),
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
                      'Schedule Information',
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
