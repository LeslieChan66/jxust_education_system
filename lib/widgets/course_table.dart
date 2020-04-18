import 'package:flutter/material.dart';

class CourseTable extends StatefulWidget {
  CourseTable(this.appbarHeight);
  final double appbarHeight;
  @override
  _CourseTableState createState() => _CourseTableState();
}

class _CourseTableState extends State<CourseTable> {
  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(color: Color(0x50a786c8), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第一大节', textDirection: TextDirection.ltr,),
                  ),
                ),
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
                  decoration: BoxDecoration(color: Color(0x50a786c8), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第一大节', textDirection: TextDirection.ltr,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: (MediaQuery.of(context).size.height - widget.appbarHeight - 30) / 5,
                  decoration: BoxDecoration(color: Color(0x50a786c8), borderRadius: BorderRadius.circular(3.0)),
                  child: Center(
                    child: Text('第一大节', textDirection: TextDirection.ltr,),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
