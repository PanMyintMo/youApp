// Mocks generated by Mockito 5.4.4 from annotations
// in youapp/test/bloc_testing/user_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:youapp/profile/repository/profile_repository.dart' as _i3;
import 'package:youapp/services/baseapiservices.dart' as _i2;

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

/// A class which mocks [ProfileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileRepository extends _i1.Mock implements _i3.ProfileRepository {
  MockProfileRepository() {
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
  _i4.Future<dynamic> createProfile(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #createProfile,
          [data],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<dynamic> getProfile() => (super.noSuchMethod(
        Invocation.method(
          #getProfile,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<dynamic> updateProfile(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #updateProfile,
          [data],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}
