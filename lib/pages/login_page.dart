import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jxust_education_system/configs/config.dart';
import 'package:jxust_education_system/states/profile_change_notifier.dart';
import 'package:jxust_education_system/widgets/login_form.dart';
import 'package:jxust_education_system/widgets/show_loading.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  final TextEditingController _verifiedController = new TextEditingController();
  bool passwordVisible = false;
  bool rememberPassword = true;
  GlobalKey _formKey = new GlobalKey<FormState>();
  List<int> imageBytes = new List<int>();
  Image verificationCodeImage;
  LoginForm _loginForm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('login page init');
    _loginForm = LoginForm();
    _buildCodeImage().then((res) {
      setState(() {
        imageBytes = res.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('login page build');
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/login_bg5.jpg',
                ),
                fit: BoxFit.cover,
              )),
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
                  child: _loginForm),
            ],
          ),
        ),
      )
    );
  }

  _buildLoginForm() {
    return Theme(
        data: new ThemeData(primaryColor: Colors.blue, hintColor: Colors.white),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 用户名
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<UserModel>(context).username)),
                onChanged: (value) {
                  _password = value;
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
