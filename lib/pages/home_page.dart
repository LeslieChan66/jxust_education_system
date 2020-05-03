import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:html/dom.dart' as Dom;
import 'package:html/parser.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/services/api.dart';
import 'package:jxust_education_system/utils/parse_html.dart';
import 'package:jxust_education_system/widgets/course_table.dart';
import 'package:jxust_education_system/widgets/drawer.dart';
import 'package:jxust_education_system/widgets/show_loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

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
  String weekNo;
  GlobalKey _couseTableKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfoDoc = parse(widget.userInfoData);
    courseTableDoc = parse(widget.courseTableData);
    weekNo = parseWeekNo(userInfoDoc);
  }

  // 日期选择弹窗
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

  // 获取屏幕截图
  Future<Uint8List> getScreenImage() async {
    RenderRepaintBoundary boundary =
    _couseTableKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  // 保存图片
  Future<String> _saveImage(Uint8List imageBytes) async {
    final result = await ImageGallerySaver.saveImage(imageBytes);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBar = new AppBar(
      brightness: Brightness.light,
      title: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.calendar_today), Text(weekNo)],
        ),
        onTap: () async {
          List list = await _showDatePicker(context);
          if (list != null) {
            showLoading(context, '加载中');
            var res = await HttpUtils.getCourseTable(list: list);
            Navigator.pop(context);
            print(res);
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
            }
            else if(res == 504) {
              Toast.show('请求超时', context);
            }
            else {
              setState(() {
                weekNo = Configs.weekList[list[1]];
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
                value: '0',
                child: Text('保存课表'),
              ),
              PopupMenuItem(
                value: '1',
                child: Text('换个颜色'),
              )
            ];
          },
          onSelected: (String value) async {
            if (value == '0') {
              if (await Permission.storage.request().isDenied) {
                Toast.show('Permission denied', context);
              }
              Uint8List pngBytes = await getScreenImage();
              String path = await _saveImage(pngBytes);
              if (path.length > 2) {
                Toast.show('保存成功', context);
              }
            } else if (value == '1') {
              setState(() {

              });
            }
          },
        ),
      ],
    );
    return Scaffold(
      appBar: _appBar,
      drawer: MyDrawer(parseUserInfo(userInfoDoc)),
      body: RepaintBoundary(
        key: _couseTableKey,
        child: Container(
          color: Colors.white,
          child: CourseTable(_appBar.preferredSize.height, courseTableDoc),
        )
      ),
    );
  }
}
