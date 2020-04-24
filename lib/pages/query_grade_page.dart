import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/model/grade.dart';
import 'package:jxust_education_system/services/api.dart';

class QueryGradePage extends StatefulWidget {
  @override
  _QueryGradePageState createState() => _QueryGradePageState();
}

class _QueryGradePageState extends State<QueryGradePage> {
  Map map = {
    // 显示方式
    'xsfs': 'all',
    // 开课时间
    'kksj': '',
    // 课程名称
    'kcmc': '',
    // 课程性质
    'kcxz': '',
  };
  int semesterIndex = 0;
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
            child: Image.asset(
              'assets/images/query_grade.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
        Positioned(
            top: MediaQuery.of(context).size.width * 146 / 344 - 10,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              height: 50,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${Configs.semesterGradeList[semesterIndex]}',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    onTap: () async {
                      int index = await _showDatePicker(context);
                      print(index);
                      setState(() {
                        semesterIndex = index;
                        if (index == 0) {
                          map = {
                            // 显示方式
                            'xsfs': 'all',
                            // 开课时间
                            'kksj': '',
                            // 课程名称
                            'kcmc': '',
                            // 课程性质
                            'kcxz': '',
                          };
                        } else {
                          map = {
                            // 显示方式
                            'xsfs': 'all',
                            // 开课时间
                            'kksj': Configs.semesterGradeList[index],
                            // 课程名称
                            'kcmc': '',
                            // 课程性质
                            'kcxz': '',
                          };
                        }
                      });
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.insert_chart,
                        color: Colors.blue,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Text(
                          '综合统计',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
        FutureBuilder(
          future: HttpUtils.getGradeTable(map),
          builder: (context, snapshot) {
            print('future build');
            if (snapshot.hasData) {
              List<DataRow> rows = new List<DataRow>();
              List<Grade> items = snapshot.data;
              for (int i = 0; i < snapshot.data.length; i++) {
                var row = DataRow(cells: [
                  DataCell(Text(items[i].courseName.length < 15
                      ? items[i].courseName
                      : items[i].courseName.substring(0, 14))),
//                  DataCell(Text(items[i].date)),
                  DataCell(Text(items[i].score.toString())),
                  DataCell(Text(items[i].credit.toString())),
//                  DataCell(Text(items[i].testProperty)),
//                  DataCell(Text(items[i].courseProperty)),
                ]);
                rows.add(row);
              }
              return Positioned(
                top: MediaQuery.of(context).size.width * 146 / 344 + 50,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20.0),
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.width * 146 / 344 + 165),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        horizontalMargin: 0.0,
                        columnSpacing: 0.0,
                        columns: [
                          DataColumn(label: Text('课程名称')),
//                      DataColumn(label: Text('开课时间')),
                          DataColumn(
                              label: Text(
                            '课程成绩',
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                            label: Text(
                              '课程学分',
                              textAlign: TextAlign.center,
                            ),
                          ),
//                      DataColumn(label: Text('考试性质')),
//                      DataColumn(label: Text('课程性质')),
                        ],
                        rows: rows,
                      ),
                    )),
              );
            } else {
              return Positioned(
                top: MediaQuery.of(context).size.width * 146 / 344 + 50,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.width * 146 / 344 + 165),
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/data_loading.png', width: 150,),
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: Text('数据加载中...', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent, fontSize: 18.0),),
                        )
                      ],
                    )
                ),
              );
            }
          },
        )
      ],
    );
  }

  _showDatePicker(BuildContext context) {
    int semesterIndex = 0;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.blue, fontSize: 16.0),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          '完成',
                          style: TextStyle(color: Colors.blue, fontSize: 16.0),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(semesterIndex);
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: CupertinoPicker(
                          backgroundColor: Colors.transparent,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            semesterIndex = value;
                          },
                          children: Configs.semesterGradeList.map((item) {
                            return Center(
                              child: Text(item),
                            );
                          }).toList()),
                    ),
                  )
                ],
              ));
        });
  }
}
