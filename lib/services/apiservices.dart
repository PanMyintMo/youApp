import 'package:dio/dio.dart';
import 'package:youapp/services/baseurl.dart';
import 'package:youapp/services/requestintector.dart';

class DioProvider {
  static final Dio _dio = Dio();

  static Dio get dio {
    _dio.options = BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        baseUrl: AppBaseUrls.baseUrl,
        headers: {'Content-Type': 'application/json'});

    _dio.interceptors.add(RequestInterceptor());

    return _dio;
  }
}
