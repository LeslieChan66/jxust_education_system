import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jxust_education_system/pages/about_app_page.dart';
import 'package:jxust_education_system/pages/about_us_page.dart';
import 'package:jxust_education_system/pages/login_page.dart';
import 'package:jxust_education_system/pages/query_grade_page.dart';
import 'package:jxust_education_system/pages/share_page.dart';
import 'package:jxust_education_system/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';
import 'common/global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) {
    runApp(MyApp());
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UserModel()),
        ],
        child: MaterialApp(
          title: '教务系统',
          theme: ThemeData(
              primaryColor: Color(0xffffffff),
              brightness: Brightness.light
          ),
          routes: {
            'login_page': (context) => LoginPage(),
            'query_grade_page': (context) => QueryGradePage(),
            'share_page': (context) => SharePage(),
            'about_us_page': (context) => AboutUsPage(),
            'about_app_page': (context) => AboutAppPage(),
          },
          home: LoginPage(),
        ));
  }
}

