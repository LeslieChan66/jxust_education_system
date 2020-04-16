import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF2C3E54),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100.0),
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                      child: Image.asset('assets/images/logo.jpg'),
                    ),
                  ),
                  Container(
                    child: Text(
                      '江西理工大学教务系统',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 200,
                margin: EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildLoginForm()),
            FutureBuilder(
              future: _buildCodeImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(Uint8List.fromList(snapshot.data.data));
                } else {
                  return Text('errot');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Theme(
        data: new ThemeData(primaryColor: Colors.blue, hintColor: Colors.white),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 用户名
              TextFormField(
                style: TextStyle(color: Color(0xFFAFB7BA)),
                decoration: InputDecoration(
                    hintText: '请输入用户名',
                    hintStyle: TextStyle(color: Color(0xFFAFB7BA)),
                    contentPadding: EdgeInsets.all(10.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFFAFB7BA),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAFB7BA)),
                        borderRadius: BorderRadius.circular(15.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
              ),
              // 密码
              TextFormField(
                style: TextStyle(color: Color(0xFFAFB7BA)),
                decoration: InputDecoration(
                  hintText: '请输入密码',
                    hintStyle: TextStyle(color: Color(0xFFAFB7BA)),
                    contentPadding: EdgeInsets.all(10.0),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xFFAFB7BA),
                    ),
                    suffixIcon: GestureDetector(
                      child: !passwordVisible
                          ? Icon(Icons.visibility, color: Color(0xFFAFB7BA))
                          : Icon(Icons.visibility_off,
                              color: Color(0xFFAFB7BA)),
                      onTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAFB7BA)),
                        borderRadius: BorderRadius.circular(15.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                obscureText: !passwordVisible,
              ),
              // 登录按钮
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      color: Color(0xFF009A9A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                      onPressed: () {

                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  _buildCodeImage() async {
    Response<List<int>> rs = await Dio().get<List<int>>('https://jw.webvpn.jxust.edu.cn/verifycode.servlet',
      options: Options(responseType: ResponseType.bytes), //设置接收类型为bytes
    );
    return rs;
  }
}
