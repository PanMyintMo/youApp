import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:youapp/auth_repository/auth_repo.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/response/authresponse.dart';

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
          emit(state.copyWith(status: Status.success, response: authResponse));
        } else if (authResponse.message ==
            AppString.userAlreadyRegisterMessage) {
          emit(state.copyWith(status: Status.success, response: authResponse));
        }
      } catch (e) {
        emit(state.copyWith(
          status: Status.failed,
        ));
      }
    });
  }
}
