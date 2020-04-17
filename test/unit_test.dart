import 'dart:typed_data';



import 'package:flutter_test/flutter_test.dart';
import 'package:jxust_education_system/services/api.dart';



void main() {
  test('test', () async {
    var rs = await HttpUtils.request('/Logon.do?method=logon', method: 'POST');
    print(rs);
  });
}