import 'package:youapp/util/app_logger.dart';

class ProfileResponse {
  final String message;
  final UserData userData;

  ProfileResponse({required this.message, required this.userData});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    try {
      return ProfileResponse(
        message: json['message'] ?? 'No message',
        userData: UserData.fromJson(json['data'] ?? {}),
      );
    } catch (e) {
      logger.d('Error parsing ProfileResponse: $e');
      throw Exception('Error parsing ProfileResponse');
    }
  }
}

class UserData {
  final String email;
  final String username;
  final String name;
  final String birthday;
  final String horoscope;
  final int height;
  final int weight;
  final List<String> interests;

  UserData({
    required this.email,
    required this.username,
    required this.name,
    required this.birthday,
    required this.horoscope,
    required this.height,
    required this.weight,
    required this.interests,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    try {
      return UserData(
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        name: json['name'] ?? '',
        birthday: json['birthday'] ?? '',
        horoscope: json['horoscope'] ?? '',
        height: json['height'] ?? 0,
        weight: json['weight'] ?? 0,
        interests: json['interests'] != null
            ? List<String>.from(json['interests'])
            : [],
      );
    } catch (e) {
      logger.d('Error parsing UserData: $e');
      throw Exception('Error parsing UserData');
    }
  }
}
