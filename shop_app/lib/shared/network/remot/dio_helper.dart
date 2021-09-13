// this class must be initialize before runApp method
import 'package:dio/dio.dart';
import 'package:shop_app/shared/components/constants.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true),
    );
  }
}
