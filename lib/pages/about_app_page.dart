import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class AboutAppPage extends StatelessWidget {
  String desc = '这是一个给江西理工大学学生使用的教务系统APP，目前实现了查看各个学期的课表以及成绩，如果有人使用的话，后续会继续实现新的功能';
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
          Text('隐私', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text('本软件并非江西理工大学官方软件，所有信息都是来自江西理工大学教务系统官网，如与教务系统上有出入，请以学校教务系统为准。本软件会模拟你的登录操作，从学校教务网站上获取网页上的信息，本软件不会上传你的任何信息到除江西理工大学教务系统以外的任何网站。',),
          ),
          Text('Bugs反馈', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text('任何使用方面的问题都可以联系作者反馈',),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
