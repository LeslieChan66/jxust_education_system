import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:jxust_education_system/services/api.dart';

void main() {
  test('test', () async {
    var res = await HttpUtils.request('/verifycode.servlet');
    print(res is Uint8List);
  });
}