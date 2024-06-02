  import 'package:flutter/material.dart';
import 'package:maternity/pages/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

  void main() {
    runApp(const MyApp());
  }


  class MyApp extends StatelessWidget {
    const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Responsive Sizer Example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:const  Login(),
        );
      },
      maxTabletWidth: 900, 
    );
  }
}

