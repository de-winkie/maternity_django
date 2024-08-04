import 'package:flutter/material.dart';
import 'package:maternity/constant.dart';
import 'package:maternity/pages/menu.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final response = await http.post(
      Uri.parse('$api/user/login/'),  
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'password': password.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      
      String token = responseData['access'];
      int userId = responseData['id'];
      String userName = responseData['username'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Menu(
            token: token,
            userId: userId,
            userName: userName,
          ),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Login failed. Please check your credentials and try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(
          left: 2.h,
          right: 2.h,
          top: 16.h,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sign in Now',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Please Sign In To Continue Our App',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Username',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: username,
              style: TextStyle(
                color: kBlackColor,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kfilledColor),
                  borderRadius: BorderRadius.circular(1.h),
                  gapPadding: 1.h,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kfilledColor),
                  gapPadding: 1.h,
                  borderRadius: BorderRadius.circular(1.h),
                ),
                hintText: 'Enter Username',
                filled: true,
                fillColor: kfilledColor,
                hintStyle: TextStyle(
                  color: kGreySilverColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: password,
              obscureText: true,
              style: TextStyle(
                color: kBlackColor,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kfilledColor),
                  borderRadius: BorderRadius.circular(1.h),
                  gapPadding: 1.h,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kfilledColor),
                  gapPadding: 1.h,
                  borderRadius: BorderRadius.circular(1.h),
                ),
                hintText: 'Enter Password',
                filled: true,
                fillColor: kfilledColor,
                hintStyle: TextStyle(
                  color: kGreySilverColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forget Password',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            isLoading
                ? CircularProgressIndicator()
                : Container(
                    width: 100.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                    child: TextButton(
                      onPressed: login,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: kWhiteColor, fontSize: 16.sp),
                      ),
                    ),
                  ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
