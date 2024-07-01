import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/module/auth/auth_module.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/routes/auth/auth_routes.dart';
import 'package:youapp/util/app_logger.dart';

import 'package:youapp/util/app_router.dart';
import 'package:youapp/util/app_string.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository = AuthRepository();

  AuthBloc() : super(const AuthState(status: Status.initial)) {
    on<AuthEvent>((event, emit) {});

    on<RegisterEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        final response =
            await repository.registerApi(event.authRequestModel.toJson());

        final authResponse = AuthResponse.fromJson(response);

        if (authResponse.message == AppString.registerSuccessMessage) {
          // AppRouter.changeRoute<AuthModule>(
          //   AuthRoutes.login,
          //   isReplaceAll: true,
          // );

          emit(state.copyWith(
              status: Status.success, response: authResponse));
         // EasyLoading.showSuccess(authResponse.message);
        } else if (authResponse.message ==
            AppString.userAlreadyRegisterMessage) {
          logger.d("User Already exit");
          emit(state.copyWith(status: Status.failed));
         // EasyLoading.showToast(authResponse.message);
        } else {
          emit(state.copyWith(status: Status.failed));
        }
      } catch (e) {
        emit(state.copyWith(
          status: Status.failed,
        ));

       // EasyLoading.showError('Failed');
      }
    });
  }
}
