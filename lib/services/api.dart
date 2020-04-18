import 'package:html/parser.dart' show parse;
import 'package:dio/dio.dart';
import 'dart:async';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';

class HttpUtils {
  /// global dio object
  static Dio dio;

  /// default options
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String API_PREFIX = 'https://jw.webvpn.jxust.edu.cn';
  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static final CookieJar cookieJar = CookieJar();

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        baseUrl: API_PREFIX,
      );
      dio = new Dio(options);
      dio.interceptors.add(CookieManager(cookieJar));
    }
    return dio;
  }

  static Future getCodeImage(String url) async {
    Dio dio = createInstance();
    Response<List<int>> res = await dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));
    print(cookieJar.loadForRequest(Uri.parse(API_PREFIX)));
    return res;
  }

  static Future login(String username, String password, String verify_code) async {
    Dio dio = createInstance();
    Response response = await dio.post('/Logon.do?method=logon&flag=sess');
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
    Map loginForm = {
      "userAccount": username,
      "userPassword": password,
      "RANDOMCODE": verify_code,
      "encoded": encoded
    };
    dio.options.contentType="application/x-www-form-urlencoded";
    Response response1 = await dio.post('/Logon.do?method=logon', data: loginForm, options: Options(validateStatus: (status) {
      return status < 500;
    }));
    var redirect = response1.headers['location'][0];
    await dio.get(redirect);
    await getCodeImage('/verifycode.servlet');
    var q = await dio.get(redirect);
    return q.data;
//    var document = parse(q.data);
//    print(document.outerHtml);
  }
}