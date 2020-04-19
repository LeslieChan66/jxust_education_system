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
            height: 30,
            child: Row(
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x502764fc),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x50f76243),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                      child: Text('周一', textAlign: TextAlign.center,)
                  ),
                ),
                Container(
                  height: 30,
                    decoration: BoxDecoration(color: Color(0x50764263),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周二', textAlign: TextAlign.center,),
                  )
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x50793436),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周三', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x50c6f7a7),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周四', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x5065e387),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周五', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x50a073b9),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周六', textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0x50fc3040),borderRadius: BorderRadius.circular(3.0)),
                  width: MediaQuery.of(context).size.width / 8,
                  child: Center(
                    child: Text('周日', textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width / 8,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x50a786c8), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第一大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x5080c0d6), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第二大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x50a6897a), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第三大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x50283929), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第四大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x50a7c8c8), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第五大节', textDirection: TextDirection.ltr,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 8,
          top: 30,
          child: Container(
            width: MediaQuery.of(context).size.width / 8 * 7,
            height: MediaQuery.of(context).size.height - 30 - widget.appbarHeight,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, //横轴三个子widget
                  childAspectRatio: (MediaQuery.of(context).size.width / 8) / ((MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5)  //宽高比为1时，子widget
              ),
              children: courseList.map((item) {
                var courseName;
                var place;
                if (item.length != 1) {
                  courseName = item.split(new RegExp(r"[1-9]"))[0];
                  place = (item.split(']')[1]).split('(')[0];
                }
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(color: Color(0x50800080), borderRadius: BorderRadius.circular(3.0)),
                  child: Text(item.length == 1 ? item : ('$courseName\n@$place'), style: TextStyle(color: Colors.white),),
                );
              }).toList()
            ),
          ),
        )
      ],
    );
  }
}
