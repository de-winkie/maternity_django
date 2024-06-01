import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(
          left: 2.h,
          right: 2.h,
          top: 2.h,
        ),
        child:
      Column(
        children: [
Align(
  child: Text('MMS',style: GoogleFonts.poppins(),),
)
        ],
      ),),
    );
  }
}