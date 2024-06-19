part of 'login_bloc.dart';

@immutable
class LoginState {
  final Status addStatus;
  final LoginResponse? response;

  const LoginState({required this.addStatus, this.response});

  LoginState copyWith({
    Status? addStatus,
    LoginResponse? response,
  }) {
    return LoginState(
        addStatus: addStatus ?? this.addStatus,
        response: response ?? this.response);
  }
}
