// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // For formatting date
import 'package:maternity/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'schedule_details.dart'; // Ensure you have this import

class ScheduleScreen extends StatefulWidget {
  final int userId;
  const ScheduleScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<dynamic> schedules = [];

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    final response = await http.get(Uri.parse('$api/schedule/schedules/user/${widget.userId}/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        schedules = data ?? []; // Handle potential null data
      });
    } else {
      // Handle error
      print('Failed to load schedules');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: schedules.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(2.h),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                final scheduleName = schedule['scheduleName'] ?? 'No Name'; // Default value
                final scheduleDate = schedule['date'] ?? 'No Date'; // Default value
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleDetails(scheduleId: schedule['id']),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, size: 24.sp, color: Colors.blue),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  scheduleName,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  DateFormat('yyyy-MM-dd').format(DateTime.tryParse(scheduleDate) ?? DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
