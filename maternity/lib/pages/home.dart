
import 'package:flutter/material.dart';
import 'package:maternity/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:maternity/pages/widget/chart.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final bool isShowingMainData= true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Container(
      padding: EdgeInsets.only(
        top:0.h,
        left: 1.h,
        right: 1.h,
      ),
        child: Column(
          
          children: [
                Row(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children:
 [
    Text( 'Pregnent Calender',textAlign:TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),),
                      ],),

SizedBox(height: 2.h,),
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
    SizedBox(height:3.h),
                    Row(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children:
 [
    Text( 'Pregnent Calender',textAlign:TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),),
                      ],),

                        SizedBox(height:2.h),
    SizedBox(
      height: 30.h,
      width: 100.w,
      child:       Chart(isShowingMainData: isShowingMainData),
    ),
SizedBox(height: 3.5.h,),
  
   SizedBox(
    height: 2.h,
   ),

Row(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children:
 [
    Text( 'Appoitment history',textAlign:TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),),
                          Text( 'See All',textAlign:TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color:Colors.grey,
                        ),),
],),
                        SizedBox(height: 2.h,),
                        Row(
                          children: [
                            Container(
width:30.w,
height:15.h,
padding: EdgeInsets.only(left:1.h,right:1.h),
       decoration :BoxDecoration(
        color: kWhiteColor,
      borderRadius: BorderRadius.circular(1.h),
      boxShadow:const [
        BoxShadow(
          color:kLightSilverColor,
          blurRadius: 1,
          spreadRadius: 1,
          blurStyle: BlurStyle.normal,

          offset: Offset(1, 1)
          
        ),
        
      ],
       )    ,         
       child:Row(
        children: [
          Text('29',
                        style: TextStyle(
                          color:kPrimaryColor,
                          fontSize: 28.sp,
                         
                          fontWeight: FontWeight.w700
                        ),),
                               Text('Jun',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),),
        ],
       ) 
           ),
       SizedBox(
        width:1.h,
       ),
       
           Container(
width:30.w,
height:15.h,
padding: EdgeInsets.only(left:1.h,right:1.h),
       decoration :BoxDecoration(
        color: kWhiteColor,
      borderRadius: BorderRadius.circular(1.h),
      boxShadow:const [
        BoxShadow(
          color:kLightSilverColor,
          blurRadius: 1,
          spreadRadius: 1,
          blurStyle: BlurStyle.normal,

          offset: Offset(1, 1)
          
        ),
        
      ],
       )    ,         
       child:Row(
        children: [
          Text('29',
                        style: TextStyle(
                          color:kPrimaryColor,
                          fontSize: 28.sp,
                         
                          fontWeight: FontWeight.w700
                        ),),
                               Text('Jun',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),),
        ],
       ) 
           ),
             SizedBox(
        width:1.h,
       ),
           Container(
width:30.w,
height:15.h,
padding: EdgeInsets.only(left:1.h,right:1.h),
       decoration :BoxDecoration(
        color: kWhiteColor,
      borderRadius: BorderRadius.circular(1.h),
      boxShadow:const [
        BoxShadow(
          color:kLightSilverColor,
          blurRadius: 1,
          spreadRadius: 1,
          blurStyle: BlurStyle.normal,

          offset: Offset(1, 1)
          
        ),
        
      ],
       )    ,         
       child:Row(
        children: [
          Text('29',
                        style: TextStyle(
                          color:kPrimaryColor,
                          fontSize: 28.sp,
                         
                          fontWeight: FontWeight.w700
                        ),),
                               Text('Jun',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),),
        ],
       ) 
           ),
       
                          ],
                        )
       
          ],
        ),
   )
 ,
    ); }

}


