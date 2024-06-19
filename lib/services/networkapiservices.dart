import 'dart:io';

import 'package:dio/dio.dart';
import 'package:youapp/services/app_exception.dart';
import 'package:youapp/services/baseapiservices.dart';
import 'package:youapp/util/app_logger.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future deleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await dio.delete(url).timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getResponse({required String url}) async {
    dynamic responseJson;

    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 15));

      logger.d("Reach here and response for get ${response.data}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, data) async {
    dynamic responseJson;

    try {
      final response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
      logger.d("Response json is $responseJson");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    logger.d("Network api services $responseJson");
    return responseJson;
  }

  @override
  Future putApiResponse(String url, data) async {
    dynamic responseJson;

    try {
      final response =
          await dio.put(url, data: data).timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
      logger.d("Response json is $responseJson");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    logger.d("Network api services $responseJson");
    return responseJson;
  }
}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.data;

    case 400:
      throw BadRequestException(response.statusMessage.toString());

    case 500:
      throw UnathorizedException(response.statusMessage.toString());
    case 404:
      throw UnathorizedException(response.statusMessage.toString());
    default:
      throw FetchDataException('Error : ${response.statusMessage.toString()}');
  }
}
