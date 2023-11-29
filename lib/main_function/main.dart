import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
 import 'package:firebase_core/firebase_core.dart';

import '../screens/home_page.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseReference db=FirebaseDatabase.instance.ref("_alarms").child('alarms');

  runApp( const AlarmApp());
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(),
    );
  }
}

