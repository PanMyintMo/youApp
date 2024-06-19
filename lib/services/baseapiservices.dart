import 'package:dio/dio.dart';
import 'package:youapp/services/apiservices.dart';

abstract class BaseApiServices {
  final Dio dio = DioProvider.dio;

  Future<dynamic> getResponse({required String url});

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> putApiResponse(String url, dynamic data);

  Future<dynamic> deleteApiResponse(String url);
}
