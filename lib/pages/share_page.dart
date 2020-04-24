import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white))
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('分享',), centerTitle: false, elevation: 0,),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.deepOrange,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Center(
              child: Text('Talk is cheap, show me the code.', style: TextStyle(color: Colors.white, fontSize: 16.0),),
            ),
          ),
          Container(
            width: 250,
            height: 250,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Center(
              child: QrImage(
                data: 'https://chan66.lanzous.com/ibuk7ve',
                size: 200,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text('Scan this qrcode to download', style: TextStyle(color: Colors.white, fontSize: 16.0),),
          )
        ],
      ),
    );
  }
}
