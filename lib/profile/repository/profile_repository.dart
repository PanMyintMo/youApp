import 'package:youapp/services/baseapiservices.dart';
import 'package:youapp/services/baseurl.dart';
import 'package:youapp/services/networkapiservices.dart';
import 'package:youapp/util/app_logger.dart';

class ProfileRepository {
  BaseApiServices apiServices = NetworkApiService();

  Future<dynamic> createProfile(dynamic data) async {
    try {
      dynamic response = await apiServices.postApiResponse(
          AppBaseUrls.createProfileEndPoint, data);
      logger.e("Enter Here$response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProfile() async {
    try {
      //  logger.d("Route for rofile is ${AppBaseUrls.getProfileEndPoint}");
      dynamic response =
          await apiServices.getResponse(url: AppBaseUrls.getProfileEndPoint);

      //  logger.d("Prof repository rp is $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProfile(dynamic data) async {
    try {
      dynamic response = await apiServices.putApiResponse(
          AppBaseUrls.updateProfileEndPoint, data);

      logger.e(response);
      return response;
    } catch (e) {
      logger.e("Error in Update Profile repository $e");
      rethrow;
    }
  }
}
