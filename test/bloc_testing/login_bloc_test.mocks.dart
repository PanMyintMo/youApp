// Mocks generated by Mockito 5.4.4 from annotations
// in youapp/test/bloc_testing/login_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:youapp/auth_repository/auth_repo.dart' as _i3;
import 'package:youapp/services/baseapiservices.dart' as _i2;
import 'package:youapp/services/share_preference.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBaseApiServices_0 extends _i1.SmartFake
    implements _i2.BaseApiServices {
  _FakeBaseApiServices_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BaseApiServices get apiServices => (super.noSuchMethod(
        Invocation.getter(#apiServices),
        returnValue: _FakeBaseApiServices_0(
          this,
          Invocation.getter(#apiServices),
        ),
      ) as _i2.BaseApiServices);

  @override
  set apiServices(_i2.BaseApiServices? _apiServices) => super.noSuchMethod(
        Invocation.setter(
          #apiServices,
          _apiServices,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<dynamic> registerApi(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #registerApi,
          [data],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<dynamic> loginApi(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #loginApi,
          [data],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<dynamic> signOutUser() => (super.noSuchMethod(
        Invocation.method(
          #signOutUser,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}

/// A class which mocks [SharePreferenceData].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharePreferenceData extends _i1.Mock
    implements _i5.SharePreferenceData {
  MockSharePreferenceData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get accessToken => (super.noSuchMethod(
        Invocation.getter(#accessToken),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#accessToken),
        ),
      ) as String);

  @override
  set accessToken(String? _accessToken) => super.noSuchMethod(
        Invocation.setter(
          #accessToken,
          _accessToken,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> setToken(String? token) => (super.noSuchMethod(
        Invocation.method(
          #setToken,
          [token],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String?> getToken() => (super.noSuchMethod(
        Invocation.method(
          #getToken,
          [],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);
}
