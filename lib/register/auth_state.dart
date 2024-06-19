part of 'auth_bloc.dart';

@immutable
class AuthState {
  final Status addStatus;
  final AuthResponse? response;

  const AuthState({required this.addStatus, this.response});

  AuthState copyWith({
    Status? addStatus,
    AuthResponse? response,
  }) {
    return AuthState(
        addStatus: addStatus ?? this.addStatus,
        response: response ?? this.response);
  }
}
