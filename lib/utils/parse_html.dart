import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:jxust_education_system/model/grade.dart';

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

String parseWeekNo(Document document) {
  var index = document.querySelector('#li_showWeek').querySelector('span').text;
  return index;
}

List parseCourseTable(Document document) {
  var tds = document.querySelectorAll('td');
  List courseList = new List(35);
  try {
    for (int i = 0; i < 35; i++) {
      courseList[i] = tds[i].querySelector('.kbcontent').text;
    }
  } catch(e) {
    print(e);
  }
  return courseList;
}

parseGradeTable(Document document) {
  var trs = document.querySelectorAll('tr');
  List<Grade> gradeList = new List<Grade>();
  for(int i = 1; i < trs.length; i++) {
    var tds = trs[i].querySelectorAll('td');
    var date = tds[1].text;
    var courseName = tds[3].text;
    var score = double.parse(tds[5].text);
    var credit = double.parse(tds[7].text);
    var testProperty = tds[12].text;
    var courseProperty = tds[14].text;
    Grade grade = Grade(courseProperty: courseProperty, courseName: courseName, date: date, score: score, testProperty: testProperty, credit: credit );
    gradeList.add(grade);
  }
  return gradeList;
}