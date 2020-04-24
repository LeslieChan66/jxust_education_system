import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class AboutAppPage extends StatelessWidget {
  String desc = '这是一个给江西理工大学学生使用的教务系统APP，目前实现了查看各个学期的课表以及成绩，后续会继续实现新的功能';
  String qq = '1713419739';
  String wechat = 'Lin_156248';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于此应用'),),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('简介', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text(desc,),
          ),
          Text('联系作者', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('QQ: '),
                    GestureDetector(
                      child: Text(qq, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
                      onTap: () {
                        Clipboard.setData(new ClipboardData(text: qq));
                        Toast.show('已复制', context);
                      },
                    ),
                    Text('(点击可复制)')
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text('Wechat: '),
                      GestureDetector(
                        child: Text(wechat, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: wechat));
                          Toast.show('已复制', context);
                        },
                      ),
                      Text('(点击可复制)')
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
