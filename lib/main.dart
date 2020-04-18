import 'package:flutter/material.dart';
import 'package:jxust_education_system/pages/login_page.dart';

import 'configs/config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Configs.primaryColor,
      ),
      home: LoginPage(),
    );
  }
}

