part of 'profile_bloc.dart';

@immutable
class ProfileEvent {}

class ProfileCreateEvent extends ProfileEvent {
  final ProfileRequest profileRequest;
  ProfileCreateEvent({required this.profileRequest});
}

class GetUserProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileRequest updateProfileRequest;
  UpdateProfileEvent({required this.updateProfileRequest});
}
