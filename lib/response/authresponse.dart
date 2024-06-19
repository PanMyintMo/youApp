class AuthResponse {
  final String message;

  AuthResponse({required this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(message: json['message']);
  }
}

class LoginResponse extends AuthResponse {
  final String? access_token;
  LoginResponse({required super.message, required this.access_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        message: json['message'], access_token: json['access_token'] ?? "");
  }
}
