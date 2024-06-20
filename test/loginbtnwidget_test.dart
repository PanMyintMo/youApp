import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/widgets/ptb_go_button.dart';

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
