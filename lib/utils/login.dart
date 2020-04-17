import 'package:dio/dio.dart';
import '../services/api.dart';

Future preLogin(String username, String password, String verify_code) async {
  Response response = await HttpUtils.request('/Logon.do?method=logon&flag=sess', method: 'post');
  String res = response.data;
  var scode = res.split("#")[0];
  var sxh = res.split("#")[1];
  var code=username+"%%%"+password;
  var encoded="";
  for(var i=0;i<code.length;i++){
    if(i<20){
      encoded=encoded+code.substring(i,i+1)+scode.substring(0,int.parse(sxh.substring(i,i+1)));
      scode = scode.substring(int.parse(sxh.substring(i,i+1)),scode.length);
    }else{
      encoded=encoded+code.substring(i,code.length);
      i=code.length;
    }
  }
  FormData loginForm = FormData.fromMap({
    "userAccount": username,
    "userPassword": password,
    "RANDOMCODE": verify_code,
    "encoded": encoded
  });
  return loginForm;
}

Future login(FormData formData) async {
  print(formData.fields);
  Response response = await HttpUtils.request('/Logon.do?method=logon', data: formData, method: 'post');
  print(response.headers);
  print(response.statusCode);
  print(response.request);
}