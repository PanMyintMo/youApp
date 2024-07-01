import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/register/auth_bloc.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/util/app_string.dart';

import 'register_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockAuthRepository;

    setUpAll(() {
      EasyLoading.init();
    });

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc();
      authBloc.repository = mockAuthRepository;
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthState with Status.initial', () {
      expect(authBloc.state, const AuthState(status: Status.initial));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [Status.loading, Status.success] when register is successful',
      build: () {
        when(mockAuthRepository.registerApi(any)).thenAnswer((_) async => {
              'message': AppString.registerSuccessMessage,
            });
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent(
        authRequestModel: AuthRequestModel(
          username: 'Pan',
          email: 'testing@gmail.com',
          password: 'momyintPan@1',
        ),
      )),
      expect: () => [
        const AuthState(status: Status.loading),
        isA<AuthState>().having(
          (state) => state.status,
          'status',
          Status.success,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Status.loading, Status.failed] when user is already registered',
      build: () {
        when(mockAuthRepository.registerApi(any)).thenAnswer(
          (_) async => AuthResponse(
            message: AppString.userAlreadyRegisterMessage,
          ),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent(
        authRequestModel: AuthRequestModel(
          username: 'Pan',
          email: 'pan9@gmail.com',
          password: 'momyintPan@1',
        ),
      )),
      expect: () => [
        const AuthState(status: Status.loading),
        const AuthState(status: Status.failed),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Status.loading, Status.failed] on register failure',
      build: () {
        when(mockAuthRepository.registerApi(any))
            .thenThrow(Exception('Failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent(
        authRequestModel: AuthRequestModel(
          username: 'Pan',
          email: 'pan9@gmail.com',
          password: 'momyintPan@1',
        ),
      )),
      expect: () => [
        const AuthState(status: Status.loading),
        const AuthState(status: Status.failed),
      ],
    );
  });
}
