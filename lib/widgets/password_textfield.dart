import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  TextEditingController controller;
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();

  PasswordTextField(this.controller);
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
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
    );
  }
}