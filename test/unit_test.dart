import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jxust_education_system/services/api.dart';


void main() {
  test('test', () async  {
    Response res = await HttpUtils.getCourseTable();
    print(res.headers);
  });
}
