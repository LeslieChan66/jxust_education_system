import 'package:dio/dio.dart';
import 'dart:async';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
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

  /// request method
  static Future request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';


    Dio dio = createInstance();
    var result;

    try {
      Response response = await dio.request(url,
          data: data, options: new Options(method: method));
      result = response;
      print(cookieJar.loadForRequest(Uri.parse(API_PREFIX)));
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }
    return result;
  }
  static Future getCodeImage(String url) async {
    Dio dio = createInstance();
    Response<List<int>> res = await dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));
    print(cookieJar.loadForRequest(Uri.parse(API_PREFIX)));
    return res;
  }
  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        baseUrl: API_PREFIX,
        headers: {
//          "Connection": "keep-alive",
          "Content-Type": "application/x-www-form-urlencoded",
          "Origin": "https://jw.webvpn.jxust.edu.cn"
        }
      );
      dio = new Dio(options);
      dio.interceptors.add(CookieManager(cookieJar));
    }

    return dio;
  }


}
