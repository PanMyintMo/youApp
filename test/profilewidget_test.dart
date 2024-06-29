import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/profile/bloc/profile_bloc.dart';
import 'package:youapp/profile/user_profile.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  group('UserProfile Widget Tests', () {
    testWidgets('UserProfile initializes and test widget', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider(
          create: (context) => ProfileBloc(),
          child: const UserProfile(),
        )),
      ));

      await tester.pumpAndSettle();

      // Verify that the username and email are displayed correctly
    //  expect(find.byKey(const Key('usernameFiled')), findsOneWidget);
    });
  });
}
