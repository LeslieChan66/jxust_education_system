import 'dart:convert';

class Profile {
  Profile();

  String username;
  String password;

  Profile.fromJson(Map<String, dynamic> json){
    this.username = json['dateVisible'] ?? '';
    this.password = json['is_vip'] ?? '';
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'username': username,
        'password': password,
      };
}
