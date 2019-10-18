import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdgs/LoginPage.dart';
import 'HomePage.dart';
import 'SingupPage.dart';
import 'actions.dart';


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
      home: HomePage(),
      routes: {
        '/log-in':(context)=> LoginPage(),
        '/sign-up': (context)=> SignupScreen(),
        '/action':(context)=> ActionsList(),
        '/home':(context)=>HomePage(),
      },
    );
  }
}

