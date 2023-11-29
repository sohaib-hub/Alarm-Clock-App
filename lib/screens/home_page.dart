import 'dart:async';
import 'package:alarm_clock_app/screens/alarm_setting_page.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentTime;
  late String Time_ampm;
  late String currentDate;
  late String currentDay;
  late String currentSecondTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    updateTime(); // Initial time update
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      updateTime(); // Update time every second
    });
  }

  void updateTime() {
    final now = DateTime.now();

    currentTime = DateFormat('h:mm').format(now);
    currentSecondTime = DateFormat(' ss').format(now);
    Time_ampm = DateFormat(' a').format(now);
    currentDate = DateFormat('d,MMM,y').format(now);
    currentDay = DateFormat('EE').format(now);
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return
        Scaffold(
                 body:Container(
                   alignment: Alignment.center,
                   height: double.infinity,
                   width: double.infinity,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                           fit: BoxFit.cover,
                           image: AssetImage('assets/background.jpg'))
                     ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        "Alarm Clock",
        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold,color: Colors.white),
      ),
    SizedBox(height: 60,),

    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
        currentTime,
        style: TextStyle(fontSize: 60,color: Colors.white),
        ),
        Text(
          currentSecondTime,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        Text(
          Time_ampm,
          style: TextStyle(fontSize: 15,color: Colors.white),
        ),
      ],
    ),
    SizedBox(
  height: 10,
    ),
    Text(
    currentDate,
    style: TextStyle(fontSize: 24,color: Colors.white),
    ),
      Text(
        currentDay,
        style: TextStyle(fontSize: 24,color: Colors.white),
      ),
      SizedBox(
        height: 33,
      ),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmSetting(),));
      },

          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Set Alarm",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.access_alarms_outlined)
        ],
      )),

    ],
                   ),

    ),
        );
  }
}
