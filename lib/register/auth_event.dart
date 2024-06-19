part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final AuthRequestModel authRequestModel;
  RegisterEvent({required this.authRequestModel});
}
