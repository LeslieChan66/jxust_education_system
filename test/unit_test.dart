import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jxust_education_system/services/api.dart';


void main() {
  List list = [1,2];
  var res = getList(list);
  print(res);
}

getList(list) {
  var a;
  try {
    a = list[3];
  } catch (e) {
    return 200;
  }
  return a;
}
