import 'dart:convert';

import 'package:jxust_education_system/model/profile.dart';
import 'package:jxust_education_system/utils/localstorage.dart';


class Global {
  static Profile profile = new Profile();

  static Future init() async {
    var _profile = await LocalStorage.get('profile');

      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    // 首次安装
    profile.username = profile.username ?? '';
    profile.password = profile.password ?? '';
  }

  static setUserNameAndPwd(String username, String password) {
    profile.username = username;
    profile.password = password;
    saveProfile();
  }


  // 持久化
  static saveProfile() {
    print(jsonEncode(profile.toJson()));
    LocalStorage.save('profile', jsonEncode(profile.toJson()));
  }
}
