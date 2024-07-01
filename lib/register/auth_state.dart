part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status status;
  final AuthResponse? response;

  const AuthState({required this.status, this.response});

  AuthState copyWith({
    Status? status,
    AuthResponse? response,
  }) {
    return AuthState(
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [status, response];
}
