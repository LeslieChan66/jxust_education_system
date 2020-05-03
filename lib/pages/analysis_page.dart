import 'package:flutter/material.dart';
import 'package:jxust_education_system/model/grade.dart';

class AnalysisPage extends StatefulWidget {
  final List<Grade> gradeList;
  AnalysisPage({Key key, this.gradeList}) : super(key: key);
  @override
  _AnalysisPageState createState() => _AnalysisPageState(gradeList: gradeList);
}

class _AnalysisPageState extends State<AnalysisPage> {
  final List<Grade> gradeList;

  _AnalysisPageState({Key key, this.gradeList});



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // 平均分数
    double averageScore;
    // 总学分
    double totalCredit = 0;
    // 总成绩
    int totalScore = 0;
    // 平均绩点学分
    double averageScoreCredit;
    // 选择课程平均分数
    String selectedAverageScore = '--';
    // 总绩点学分
    double totalCreditScore = 0;
    // 选择课程总成绩
    int selectedTotalScore = 0;

    // 已选课程总学分
    double selectedTotalCredit = 0;

    // 已选课程总绩点学分
    double selectedTotalCreditScore = 0;

    // 已选课程平均绩点学分
    String selectedAverageCreditScore = '--';
    List<Grade> selectedList = new List<Grade>();
    gradeList.forEach((item) {
      if (item.selected) {
        selectedList.add(item);
      }
      totalCredit += item.credit;
      totalScore += item.score;
      totalCreditScore += (item.score * item.credit);
    });
    if (selectedList.length > 0) {
      selectedList.forEach((item) {
        selectedTotalScore += item.score;
        selectedTotalCredit += item.credit;
        selectedTotalCreditScore += (item.credit * item.score);
      });
      print(selectedTotalCredit);
      double average =  selectedTotalScore / selectedList.length;
      double average2 = selectedTotalCreditScore / selectedTotalCredit;
      selectedAverageScore = average.toStringAsFixed(2);
      selectedAverageCreditScore = average2.toStringAsFixed(2);
    }
    averageScore = totalScore / gradeList.length;
    averageScoreCredit = totalCreditScore / totalCredit;
    return Scaffold(
      appBar: AppBar(title: Text('综合统计'),),
      body: _buildBody(averageScore, selectedAverageScore, averageScoreCredit, selectedAverageCreditScore),
    );
  }

  _buildBody(double average, String selectedAverageScore, double averageCreditScore, String selectedAverageCreditScore) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('课程平均分数', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
              Text(average.toStringAsFixed(2), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('已选课程平均分数', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
              Text(selectedAverageScore, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('课程平均绩点学分', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
              Text(averageCreditScore.toStringAsFixed(2), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('已选课程平均绩点学分', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
              Text(selectedAverageCreditScore, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

