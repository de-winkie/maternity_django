import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top:0.h,
        left: 1.h,
        right: 1.h,
      ),
        child: Column(
          children: [

                  Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.h),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1.h),
                  topRight: Radius.circular(1.h),
                ),
                child: Image.asset(
                  'assets/images/munira.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(1.6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Remain day: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '12',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.8.h),

                    RichText(
                      text: const TextSpan(
                        text: 'Left day: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '18',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
   SizedBox(
    height: 2.h,
   ),
  const Text( 'Appoitment history',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),),
                        Row(
                          children: [
                            Container(
width:30.w,
height:15.h,

                            ),
                          ],
                        )
       
          ],
        )
   );
  }
}


