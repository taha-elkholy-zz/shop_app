// this class must be initialize before runApp method
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          // const url for the app
          receiveDataWhenStatusError: true,
          // set const headers here which will not changes
          headers: {'Content-Type': 'application/json'}),
    );
  }

  // get data
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'ar',
    String token = '',
  }) async {
    // set variable headers here like language (lang)
    _dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await _dio.get(url, queryParameters: query);
  }

  // post data
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String token = '',
  }) async {
    // set variable headers here like language (lang)
    _dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await _dio.post(url, data: data, queryParameters: query);
  }
}
