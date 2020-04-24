import 'package:flutter/material.dart';

class UsernameTextField extends StatefulWidget {
  TextEditingController controller;
  @override
  _UsernameTextFieldState createState() => _UsernameTextFieldState();

  UsernameTextField(this.controller);
}

class _UsernameTextFieldState extends State<UsernameTextField> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
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
    );
  }
}