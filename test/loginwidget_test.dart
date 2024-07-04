import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp/auth/login/login.dart';
import 'package:youapp/auth_bloc/login_bloc.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/widgets/youapp_button.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('YouAppButton Login Widget Tests', () {
    testWidgets(
        'should trigger onPressed callback when button is enabled and tapped',
        (WidgetTester tester) async {
      final mockCallback = MockCallback();
      const key = Key('login_button');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YouAppButton(
              key: key,
              onPressed: mockCallback,
              isEnabled: true,
              child: const Text('Login'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byKey(key), findsOneWidget);
      await tester.tap(find.byKey(key));
      verify(mockCallback()).called(1);
    });

    testWidgets(
        'two TextFormField widgets (email and password) should be found for login widget',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginWidget(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('passwordField')), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('emailField')), 'testing@gmail.com');

      await tester.enterText(
          find.byKey(const Key('passwordField')), 'TestingPassword');

      // Verify the entered text
      expect(find.text('testing@gmail.com'), findsOneWidget);
      expect(find.text('TestingPassword'), findsOneWidget);
    });

    testWidgets('should not trigger onPressed callback when button is disabled',
        (WidgetTester tester) async {
      final mockCallback = MockCallback();
      const key = Key('login_button');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YouAppButton(
              key: key,
              onPressed: mockCallback,
              isEnabled: false,
              child: const Text('Login'),
            ),
          ),
        ),
      );
      expect(find.byKey(key), findsOneWidget);
      await tester.tap(find.byKey(key));
      verifyNever(mockCallback());
    });

    testWidgets('should display correct gradient when button is enabled',
        (WidgetTester tester) async {
      const key = Key('login_button');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YouAppButton(
              key: key,
              onPressed: () {},
              isEnabled: true,
              child: const Text('Login'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byKey(key),
        matching: find.byType(Container),
      ));
      final boxDecoration = container.decoration as BoxDecoration;
      final gradient = boxDecoration.gradient as LinearGradient;

      expect(gradient.colors, [
        YouAppColor.disableBtnColor,
        YouAppColor.disableBtnOneColor,
      ]);
    });

    testWidgets('should display correct gradient when button is disabled',
        (WidgetTester tester) async {
      const key = Key('login_button');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YouAppButton(
              key: key,
              onPressed: () {},
              isEnabled: false,
              child: const Text('Login'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byKey(key),
        matching: find.byType(Container),
      ));
      final boxDecoration = container.decoration as BoxDecoration;
      final gradient = boxDecoration.gradient as LinearGradient;
      expect(gradient.colors, [
        YouAppColor.disableBtnColor.withOpacity(0.2),
        YouAppColor.disableBtnOneColor.withOpacity(0.3),
      ]);
    });
  });
}
