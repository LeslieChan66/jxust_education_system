import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/model/grade.dart';
import 'package:jxust_education_system/pages/analysis_page.dart';
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
  var gradeList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpUtils.getGradeTable(map).then((res) {
      setState(() {
        gradeList = res;
      });
    });
  }

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
                      setState(() {
                        gradeList = null;
                      });
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
                      var res = await HttpUtils.getGradeTable(map);
                      setState(() {
                        semesterIndex = index;
                        gradeList = res;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Row(
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
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => AnalysisPage(gradeList: gradeList,)
                        )
                      );
                    },
                  )
                ],
              ),
            )),
        gradeList == null
            ? Positioned(
                top: MediaQuery.of(context).size.width * 146 / 344 + 50,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.width * 146 / 344 + 165),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/data_loading.png',
                          width: 150,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: Text(
                            '数据加载中...',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                                fontSize: 18.0),
                          ),
                        )
                      ],
                    )),
              )
            : _buildTable()
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

  _buildTable() {
    List<DataRow> rows = new List<DataRow>();
    for (int i = 0; i < gradeList.length; i++) {
      var row = DataRow(cells: [
        DataCell(Container(
          margin: EdgeInsets.only(left: 10.0),
          width: 60,
          child: Text(gradeList[i].courseName.length < 15
              ? gradeList[i].courseName
              : gradeList[i].courseName.substring(0, 14)),
        )),
//                  DataCell(Text(items[i].date)),
        DataCell(Container(
          width: 20,
          child: gradeList[i].score >= 60 ? Text(gradeList[i].score.toString()) : Text(gradeList[i].score.toString(), style: TextStyle(color: Colors.red),),
        )),
        DataCell(Text(gradeList[i].credit.toString())),
        DataCell(Text(gradeList[i].testProperty)),
        DataCell(Container(
          width: 60,
          child: Text(gradeList[i].courseProperty),
        )),
      ], onSelectChanged: (selected) {
        print('11');
        setState(() {
          gradeList[i].selected = selected;
        });
      },
          selected: gradeList[i].selected ?? false);
      rows.add(row);
    }
    return Positioned(
      top: MediaQuery.of(context).size.width * 146 / 344 + 50,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.width * 146 / 344 + 165),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              horizontalMargin: 0.0,
              columnSpacing: 0.0,
              columns: [
                DataColumn(
                  label: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('课程名称'),
                  ),
                ),
//                      DataColumn(label: Text('开课时间')),
                DataColumn(
                    label: Text(
                      '成绩',
                      textAlign: TextAlign.center,
                    )),
                DataColumn(
                  label: Text(
                    '学分',
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(label: Text('考试性质')),
                DataColumn(label: Text('课程性质')),
              ],
              rows: rows,
            ),
          )),
    );
  }
}
