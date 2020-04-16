import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jxust_education_system/services/api.dart';

void main() {
  test('test', () async {
    Response<List<int>> rs = await Dio().get<List<int>>('https://jw.webvpn.jxust.edu.cn/verifycode.servlet',
      options: Options(responseType: ResponseType.bytes), //设置接收类型为bytes
    );
  });
}