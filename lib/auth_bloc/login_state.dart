part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final Status status;
  final LoginResponse? response;

  const LoginState({required this.status, this.response});

  LoginState copyWith({
    Status? status,
    LoginResponse? response,
  }) {
    return LoginState(
        status: status ?? this.status, response: response ?? this.response);
  }

  @override
  List<Object?> get props => [status, response];
}
