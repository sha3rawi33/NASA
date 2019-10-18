import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdgs/LoginThreePage.dart';
import 'HomePage.dart';
import 'SingupPage.dart';
import 'actions.dart';
import 'introScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANything ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SmartWalletOnboardingPage(),
      routes: {
        '/intro': (context)=> SmartWalletOnboardingPage(),
        '/log-in':(context)=> LoginThreePage(),
        '/sign-up': (context)=> SignUpPage(),
        '/action':(context)=> ActionsList(),
        '/home':(context)=>HomePage(),
      },
    );
  }
}


