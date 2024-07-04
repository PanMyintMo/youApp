import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/profile/bloc/profile_bloc.dart';
import 'package:youapp/profile/repository/profile_repository.dart';
import 'package:youapp/profile/request/profile_request.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  group('User Profile Bloc', () {
    late ProfileBloc profileBloc;
    late MockProfileRepository mockProfileRepository;

    setUp(() {
      mockProfileRepository = MockProfileRepository();
      profileBloc = ProfileBloc();
      profileBloc.repository = mockProfileRepository;
    });

    tearDown(() {
      profileBloc.close();
    });
    test('initial state is User Profile bloc state with Status.initial', () {
      expect(profileBloc.state, const ProfileState(status: Status.initial));
    });

    blocTest<ProfileBloc, ProfileState>(
        'emit [Status.loading, Status.success] when user profile create success',
        build: () => profileBloc,
        act: (profileBloc) async {
          when(mockProfileRepository.createProfile(any)).thenAnswer((_) async {
            return {
              'email': 'test@gmail.com',
              'username': 'Test',
              'name': 'Test',
              'birthday': '20/05/1997',
              'horoscope': 'Test',
              'height': '7cm',
              'weight': '4cm',
              'interests': '[test,pp,tt]'
            };
          });

          profileBloc.add(ProfileCreateEvent(
              profileRequest: ProfileRequest(
                  name: "test",
                  birthday: "20/05/1997",
                  height: 20,
                  weight: 20,
                  interests: ['test'])));
        },
        expect: () => [
              const ProfileState(status: Status.loading),
              isA<ProfileState>()
                  .having((state) => state.status, 'status', Status.success)
            ]);

    blocTest<ProfileBloc, ProfileState>(
      'emits [status.loading, Status.failed] when profile create fails',
      build: () => profileBloc,
      act: (profileBloc) async {
        when(mockProfileRepository.createProfile(any))
            .thenThrow(Exception('error'));

        profileBloc.add(ProfileCreateEvent(
            profileRequest: ProfileRequest(
                name: "",
                birthday: "20/05/1997",
                height: 0,
                weight: 0,
                interests: ['test'])));
      },
      expect: () => [
        const ProfileState(status: Status.loading),
        const ProfileState(status: Status.failed),
      ],
    );
  });
}
