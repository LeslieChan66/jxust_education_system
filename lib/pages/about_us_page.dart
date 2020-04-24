import 'package:flutter/material.dart';
import 'package:jxust_education_system/widgets/browser.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  width: 80,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text('版本号：1.0.0', style: TextStyle(color: Colors.grey, fontSize: 16.0),),
          ),
          Divider(),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                    child: Text('GitHub', style: TextStyle(fontSize: 18.0),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.arrow_forward_ios, size: 16.0,color: Colors.grey,),
                )
              ],
            ),
            onTap: () {
              print('11');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Browser(title: 'GitHub', url: 'https://github.com/LeslieChan66/jxust_education_system',)
              ));
            },
          ),
          Divider(),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                    child: Text('关于此应用', style: TextStyle(fontSize: 18.0),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.arrow_forward_ios, size: 16.0,color: Colors.grey,),
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, 'about_app_page');
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
