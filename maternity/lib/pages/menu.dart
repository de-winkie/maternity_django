import 'package:flutter/material.dart';
import 'package:maternity/pages/appointement.dart';
import 'package:maternity/pages/home.dart';
import 'package:maternity/pages/schedule.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    AppointmentScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Container(
          width: 100.w,
          padding: EdgeInsets.only(left:1.h, right:1.h),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
              
children: [
  ClipOval(
    child: Image.asset('assets/images/user.png',width: 14.w,height: 7.w),
  ),
  Text('Munawwar',style: TextStyle())
],
            ),
              Icon(Icons.notifications)
            ],
           
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
