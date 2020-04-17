import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/utils/login.dart';
import 'package:jxust_education_system/widgets/password_textfield.dart';
import '../services/api.dart';
import '../services/api.dart';




class LoginPage extends StatelessWidget {
  final TextEditingController _unameController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  final TextEditingController _verifiedController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('11');
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
                height: 300,
                margin: EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildLoginForm()),
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
                controller: _unameController,
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
                validator: (v) {
                  return v.trim().length == 10 ? '' : '用户名为十位数学号';
                },
              ),
              // 密码
              PasswordTextField(_pwdController),
              // 验证码
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
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
                  FutureBuilder(
                    future: _buildCodeImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(Uint8List.fromList(snapshot.data.data));
                      } else {
                        return Text('验证码加载失败');
                      }
                    },
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                      onPressed: () async {
                        var form = await preLogin(_unameController.text, _pwdController.text, _verifiedController.text);
                        login(form);
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
    await HttpUtils.request('');
    Response<List<int>> rs = await HttpUtils.getCodeImage('/verifycode.servlet'); //设置接收类型为byte
    return rs;
  }
}

