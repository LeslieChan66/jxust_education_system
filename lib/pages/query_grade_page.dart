import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QueryGradePage extends StatefulWidget {
  @override
  _QueryGradePageState createState() => _QueryGradePageState();
}

class _QueryGradePageState extends State<QueryGradePage> {
  @override
  Widget build(BuildContext context) {
    print('grade page build');

    return Scaffold(
      appBar: AppBar(
        title: Text('成绩查询'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            color: Color.fromRGBO(241, 241, 241, 1.0),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/query_grade.jpg', width: MediaQuery.of(context).size.width, fit: BoxFit.cover,)
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 146 / 344 - 10,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            height: 50,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('全部', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.insert_chart, color: Colors.blue,),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text('综合统计', style: TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.w600),),
                    )
                  ],
                )
              ],
            ),
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 146 / 344 + 40,
            child: SingleChildScrollView(
              child: Table(
                    //表格边框样式
                    border: TableBorder.all(
                      color: Colors.green,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    children: [
                      TableRow(
                        //第一行样式 添加背景色
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: [
                            Center(child: Text('课程名称',style: TextStyle(fontWeight: FontWeight.bold),),)
                          ]
                      ),
                    ],
                  ),
            ),
        )
      ],
    );
  }
}
