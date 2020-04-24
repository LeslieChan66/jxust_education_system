import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/pages/home_page.dart';
import 'package:jxust_education_system/services/api.dart';
import 'package:jxust_education_system/states/profile_change_notifier.dart';
import 'package:jxust_education_system/widgets/show_loading.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _username;
  String _password;
  bool passwordVisible = false;
  bool rememberPassword = true;
  final TextEditingController _verifiedController = new TextEditingController();
  List<int> imageBytes = new List<int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildCodeImage().then((res) {
      setState(() {
        imageBytes = res.data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    print('login form build');
    return Theme(
        data: new ThemeData(primaryColor: Colors.blue, hintColor: Colors.white),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 用户名
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<UserModel>(context).username)),
                onChanged: (value) {
                  _username = value;
                },
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
                keyboardType: TextInputType.visiblePassword,
                controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<UserModel>(context).password)),
                onChanged: (value) {
                  _password = value;
                },
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
              // 验证码
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _verifiedController,
                      style: TextStyle(color: Color(0xFFAFB7BA)),
                      decoration: InputDecoration(
                          hintText: '验证码',
                          hintStyle: TextStyle(color: Color(0xFFAFB7BA)),
                          contentPadding: EdgeInsets.all(10.0),
                          prefixIcon: Icon(
                            Icons.verified_user,
                            color: Color(0xFFAFB7BA),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFAFB7BA)),
                              borderRadius: BorderRadius.circular(15.0)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8 - 200,
                      child: imageBytes.length == 0
                          ? Text('图片加载中')
                          : Image.memory(Uint8List.fromList(imageBytes)),
                    ),
                    onTap: () async {
                      var res = await _buildCodeImage();
                      setState(() {
                        imageBytes = res.data;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: rememberPassword,
                    activeColor: Colors.blue,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        rememberPassword = value;
                      });
                    },
                  ),
                  Text(
                    '记住密码',
                    style: TextStyle(color: Color(0xFFAFB7BA), fontSize: 16.0),
                  )
                ],
              ),
              // 登录按钮
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      color: Color(0xFF009A9A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        '登录',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () async {
                        showLoading(context, "登录中");
                        try {
                          var userInfo = await HttpUtils.login(
                              _username,
                              _password,
                              _verifiedController.text);
                          var table = await HttpUtils.getCourseTable();
                          if (rememberPassword) {
                            Provider.of<UserModel>(context, listen: false)
                                .username = _username;
                            Provider.of<UserModel>(context, listen: false)
                                .password = _password;
                          }
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                                return HomePage(userInfo, table);
                              }), (route) => false);
                        } catch (e) {
                          Navigator.of(context).pop();

                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            message: "登陆失败，请检查你的用户名和密码是否正确",
                            flushbarPosition: FlushbarPosition.TOP,
                            icon: Icon(
                              Icons.warning,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context);
                        }
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
    Response<List<int>> rs =
    await HttpUtils.getCodeImage('/verifycode.servlet'); //设置接收类型为byte
    return rs;
  }
}
