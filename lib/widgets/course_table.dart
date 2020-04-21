import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:jxust_education_system/services/api.dart';
import 'package:jxust_education_system/utils/parse_html.dart';

class CourseTable extends StatefulWidget {
  CourseTable(this.appbarHeight, this.courseTableDoc);
  final dom.Document courseTableDoc;
  final double appbarHeight;
  @override
  _CourseTableState createState() => _CourseTableState();
}

class _CourseTableState extends State<CourseTable> {
  @override
  void initState() {
    print('Course table init');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('course table build');
    List courseList = parseCourseTable(widget.courseTableDoc);
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(252, 252, 252, 1.0), border: Border(bottom: BorderSide(color: Color.fromRGBO(241, 241, 241, 1.0)))),
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 50,
                  child: Center(child: Text('${DateTime.now().month}月'),)
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 1 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  child: Center(
                      child: Text('周一', textAlign: TextAlign.center,)
                  ),
                ),
                Container(
                  height: 50,
                    width: (MediaQuery.of(context).size.width -30) / 7,
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    decoration: DateTime.now().weekday == 2 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周二', textAlign: TextAlign.center,),
                  )
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 3 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周三', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 4 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周四', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 5 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周五', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 6 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周六', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width -30) / 7,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: DateTime.now().weekday == 7 ? BoxDecoration(color: Color.fromRGBO(229, 236, 240, 1.0), borderRadius: BorderRadius.circular(5.0)) : BoxDecoration(),
                  child: Center(
                    child: Text('周日', textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          child: Container(
            width: 30,
            decoration: BoxDecoration(color: Color.fromRGBO(252, 252, 252, 1.0), border: Border(right: BorderSide(color: Color.fromRGBO(241, 241, 241, 1.0)))),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5,
                  child: Center(
                    child: Text('第一大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5,
                  child: Center(
                    child: Text('第二大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5,
                  child: Center(
                    child: Text('第三大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5,
                  child: Center(
                    child: Text('第四大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5,
                  child: Center(
                    child: Text('第五大节', textDirection: TextDirection.ltr,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: 50,
          child: Container(
            width: MediaQuery.of(context).size.width-30,
            height: MediaQuery.of(context).size.height - 50 - widget.appbarHeight,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, //横轴三个子widget
                  childAspectRatio: ((MediaQuery.of(context).size.width-30)/7) / ((MediaQuery.of(context).size.height - widget.appbarHeight - 50) / 5)  //宽高比为1时，子widget
              ),
              children: courseList.map((item) {
                var courseName;
                var place;
                if (item.length != 1) {
                  courseName = item.split(new RegExp(r"[1-9]"))[0];
                  place = (item.split(']')[1]).split('(')[0];
                }
                var r = Random().nextInt(256);
                var g = Random().nextInt(256);
                var b = Random().nextInt(256);
                return courseName != null ?Container(
                  margin: EdgeInsets.only(right: 1.0, bottom: 2.0),
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                  decoration: BoxDecoration(color: Color.fromRGBO(r, g, b, 0.7), borderRadius: BorderRadius.circular(3.0),),
                  child: Text(item.length == 1 ? item : ('$courseName\n@$place'), style: TextStyle(color: Colors.white),),
                ) : Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(241, 241, 241, 1.0), style: BorderStyle.solid))),
                );
              }).toList()
            ),
          ),
        )
      ],
    );
  }
}
