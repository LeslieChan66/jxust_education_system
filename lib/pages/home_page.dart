import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as Dom;
import 'package:html/parser.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/services/api.dart';
import 'package:jxust_education_system/utils/parse_html.dart';
import 'package:jxust_education_system/widgets/course_table.dart';
import 'package:jxust_education_system/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  final String userInfoData;
  final String courseTableData;
  HomePage(this.userInfoData, this.courseTableData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dom.Document userInfoDoc;
  Dom.Document courseTableDoc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfoDoc = parse(widget.userInfoData);
    courseTableDoc = parse(widget.courseTableData);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(courseTableDoc.toString());
    AppBar _appBar = new AppBar(
      brightness: Brightness.light,
      title: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.calendar_today), Text('第五周')],
        ),
        onTap: () async {
          List list = await _showDatePicker(context);
          if (list != null) {
            var res = await HttpUtils.getCourseTable(list: list);
            if (res == 500) {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '拉取数据失败',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              '登陆凭证已失效，请重新登录',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  color: Color(0xFF009A9A),
                                  textColor: Colors.white,
                                  child: Text('返回登录界面'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            'login_page', (route) => false);
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              setState(() {
                courseTableDoc = parse(res);
              });
            }
          }
        },
      ),
      centerTitle: true,
      actions: <Widget>[
        new PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: Text('保存课表'),
              )
            ];
          },
        ),
      ],
    );
    return Scaffold(
      appBar: _appBar,
      drawer: MyDrawer(parseUserInfo(userInfoDoc)),
      body: Container(
//        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
        child: CourseTable(_appBar.preferredSize.height, courseTableDoc),
      ),
    );
  }

  _showDatePicker(BuildContext context) {
    int semesterIndex = 0;
    int weekIndex = 0;
    return showModalBottomSheet<List>(
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
                          List list = [semesterIndex, weekIndex];
                          Navigator.of(context).pop(list);
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 60) / 2,
                          child: CupertinoPicker(

                              backgroundColor: Colors.transparent,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                semesterIndex = value;
                              },
                              children: Configs.semesterList.map((item) {
                                return Center(
                                  child: Text(item),
                                );
                              }).toList()),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 60) / 2,
                          child: CupertinoPicker(
                              backgroundColor: Colors.transparent,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                weekIndex = value;
                              },
                              children: Configs.weekList.map((item) {
                                return Center(
                                  child: Text(item),
                                );
                              }).toList()),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
