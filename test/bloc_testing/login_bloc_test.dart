import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/auth_bloc/login_bloc.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/services/share_preference.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, SharePreferenceData])
void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late MockAuthRepository authRepository;
    late MockSharePreferenceData mockSharePreferenceData;

    setUp(() {
      authRepository = MockAuthRepository();
      mockSharePreferenceData = MockSharePreferenceData();
      loginBloc = LoginBloc();
      loginBloc.repository = authRepository;
      loginBloc.sharePreferenceData = mockSharePreferenceData;
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LoginState with Status.initial', () {
      expect(loginBloc.state, const LoginState(status: Status.initial));
    });

    blocTest<LoginBloc, LoginState>(
      'emits [status.loading, Status.success] when login success',
      build: () => loginBloc,
      act: (bloc) async {
        when(authRepository.loginApi(any)).thenAnswer((_) async {
          return {
            'message': 'success',
            'access_token': 'mockToken',
          };
        });

        bloc.add(LoginRequestEvent(
          loginRequestModel: AuthRequestModel(
            username: "KK",
            email: "kk@gmail.com",
            password: "Tt@12345",
          ),
        ));
      },
      expect: () => [
        const LoginState(status: Status.loading),
        isA<LoginState>()
            .having(
              (state) => state.status,
              'status',
              Status.success,
            )
            .having(
              (state) => state.response?.access_token,
              'access_token',
              'mockToken',
            ),
      ],
      verify: (_) {
        verify(authRepository.loginApi(any)).called(1);
        verify(mockSharePreferenceData.setToken('mockToken')).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [status.loading, Status.failed] when login fails',
      build: () => loginBloc,
      act: (bloc) async {
        when(authRepository.loginApi(any)).thenThrow(Exception('error'));

        bloc.add(LoginRequestEvent(
          loginRequestModel: AuthRequestModel(
            username: "Tt",
            email: "tt@gmail.com",
            password: "InvalidPassword",
          ),
        ));
      },
      expect: () => [
        const LoginState(status: Status.loading),
        const LoginState(status: Status.failed),
      ],
      verify: (_) {
        verify(authRepository.loginApi(any)).called(1);
        verifyNever(mockSharePreferenceData.setToken(any));
      },
    );
  });
}
