import 'package:dio/dio.dart';
import 'package:youapp/services/share_preference.dart';

class RequestInterceptor extends Interceptor {
  final SharePreferenceData sharePreferenceData = SharePreferenceData();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sharePreferenceData.getToken();

    // logger.d("Token value is $token ");

    options.headers['x-access-token'] = '$token';
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
