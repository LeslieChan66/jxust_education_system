import 'package:flutter/material.dart';
import 'package:html/dom.dart' as Dom;
import 'package:html/parser.dart';
import 'package:jxust_education_system/utils/parse_html.dart';
import 'package:jxust_education_system/widgets/course_table.dart';
import 'package:jxust_education_system/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  final String documentData;
  HomePage(this.documentData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dom.Document document;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    document = parse(widget.documentData);
  }
  @override
  Widget build(BuildContext context) {
    AppBar _appBar = new AppBar();
    return Scaffold(
      appBar: _appBar,
      drawer: MyDrawer(parseUserInfo(document)),
      body: Container(
//        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
        child: CourseTable(_appBar.preferredSize.height),
      ),
    );
  }
}
