import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jxust_education_system/pages/home_page.dart';
import 'package:jxust_education_system/pages/login_page.dart';
import 'package:jxust_education_system/pages/query_grade_page.dart';

import 'configs/config.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffffffff),
        brightness: Brightness.light
      ),
      routes: {
        'login_page': (context) => LoginPage(),
        'query_grade_page': (context) => QueryGradePage(),
      },
      home: LoginPage(),
    );
  }
}

