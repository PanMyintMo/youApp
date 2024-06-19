import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/module/profile/profile_module.dart';

import 'package:youapp/response/authresponse.dart';
import 'package:youapp/routes/profile/profile_routes.dart';
import 'package:youapp/services/share_preference.dart';

import 'package:youapp/util/app_router.dart';
import 'package:youapp/util/app_string.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository = AuthRepository();
  final SharePreferenceData sharePreferenceData = SharePreferenceData();

  LoginBloc() : super(const LoginState(addStatus: Status.initial)) {
    on<LoginEvent>((event, emit) {});

    on<LoginRequestEvent>(((event, emit) async {
      try {
        emit(state.copyWith(addStatus: Status.loading));

        final response = await repository.loginApi(event.loginRequestModel);
        final loginResponse = LoginResponse.fromJson(response);

        if (loginResponse.access_token != null &&
            loginResponse.access_token!.isNotEmpty) {
          sharePreferenceData.setToken(loginResponse.access_token!);

          EasyLoading.showSuccess(loginResponse.message);
          emit(state.copyWith(
            addStatus: Status.success,
            response: loginResponse,
          ));
          AppRouter.changeRoute<ProfileModule>(
            ProfileRoutes.profile,
            isReplaceAll: true,
          );
        } else if (loginResponse.message == AppString.incorrectPassword) {
          EasyLoading.showToast(loginResponse.message);
        }
      } catch (e) {
        emit(state.copyWith(addStatus: Status.failed));
      }
    }));
  }
}
