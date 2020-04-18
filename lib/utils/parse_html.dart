import 'package:html/dom.dart';
import 'package:html/parser.dart';

Map parseUserInfo(Document document) {
  var userDocument = document.querySelector('.middletopttxlr').text;
  var username = userDocument.split('：')[1].split('\n')[0];
  var department = userDocument.split("：")[3].split("\n")[0];
  var sno = userDocument.split("：")[2].split("\n")[0];
  var major = userDocument.split("：")[4].split("\n")[0];
  var classname = userDocument.split("：")[5].split("\n")[0];
  print(classname);
  Map userInfo = {
    "username": username,
    "department": department,
    "sno": sno,
    "major": major,
    "classname": classname
  };
  return userInfo;
}