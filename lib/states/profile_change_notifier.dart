
import 'package:flutter/material.dart';
import 'package:jxust_education_system/common/global.dart';
import 'package:jxust_education_system/model/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  String get username => _profile.username;
  String get password => _profile.password;

  set username(String username) {
    _profile.username = username;
    notifyListeners();
  }

  set password(String password) {
    _profile.password = password;
    notifyListeners();
  }
}

