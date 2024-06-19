part of 'profile_bloc.dart';

class ProfileState {
  final Status status;
  final ProfileResponse? response;

  const ProfileState({required this.status, this.response});

  ProfileState copyWith({Status? status, ProfileResponse? response}) {
    return ProfileState(
        status: status ?? this.status, response: response ?? this.response);
  }
}
