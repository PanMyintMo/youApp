import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/util/app_string.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/services/share_preference.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository repository = AuthRepository();
  SharePreferenceData sharePreferenceData = SharePreferenceData();

  LoginBloc() : super(const LoginState(status: Status.initial)) {
    on<LoginEvent>((event, emit) {});

    on<LoginRequestEvent>(((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));

        final response = await repository.loginApi(event.loginRequestModel);
        final loginResponse = LoginResponse.fromJson(response);

        if (loginResponse.access_token != null &&
            loginResponse.access_token!.isNotEmpty) {
          sharePreferenceData.setToken(loginResponse.access_token!);

          emit(state.copyWith(
            status: Status.success,
            response: loginResponse,
          ));
        } else if (loginResponse.message == AppString.incorrectPassword) {
          emit(state.copyWith(status: Status.success, response: loginResponse));
        }
      } catch (e) {
        emit(state.copyWith(status: Status.failed));
      }
    }));
  }
}
