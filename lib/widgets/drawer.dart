import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/services/api.dart';
class MyDrawer extends StatefulWidget {
  MyDrawer(this.userInfo);
  final Map userInfo;
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
          top: false,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/login_bg4.jpg'), fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset('assets/images/logo.jpg'),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                                child: Text(widget.userInfo['username'], style: TextStyle(color: Colors.white, fontSize: 20.0),),
                              ),
                              Text(widget.userInfo['sno'], style: TextStyle(color: Colors.white, fontSize: 16.0),),
                            ],
                          )
                        ],
                      ),

                      Text(widget.userInfo['department'] + "   " + widget.userInfo['classname'], style: TextStyle(color: Colors.white, fontSize: 16.0),),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(leading: Icon(Icons.score), title: Text('成绩查询'), onTap: () {
                        _gotoGradePage();
                      },),
                      ListTile(leading: Icon(Icons.developer_board), title: Text('培养方案')),
                      ListTile(leading: Icon(Icons.library_books), title: Text('等级考试')),
                      ListTile(leading: Icon(Icons.comment), title: Text('一键评教')),
                      ListTile(leading: Icon(Icons.exit_to_app), title: Text('退出登录'), onTap: () {
                        _logout();
                      },)
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void _logout() {
    HttpUtils.logout();
    Navigator.pushNamed(context, 'login_page');
  }

  void _gotoGradePage() {
    Navigator.pushNamed(context, 'query_grade_page');
  }
}

