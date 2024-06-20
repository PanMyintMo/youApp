import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/widgets/ptb_go_button.dart';

class MockCallBack extends Mock {
  void call();
}

void main() {
  group('YouApp register button widget test', () {
    testWidgets(
        'should trigger onPressed callback when button is enable and tap',
        (tester) async {
      final mockCallBack = MockCallBack();
      const key = Key('Register_Btn');

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: YouAppButton(
              key: key,
              onPressed: mockCallBack,
              isEnabled: true,
              child: const Text('Register')),
        ),
      ));

      expect(find.byKey(key), findsOneWidget);
      await tester.tap(find.byKey(key));
      verify(mockCallBack()).called(1);
    });
  });

  testWidgets('should not trigger onPressed callback when button is disable',
      (tester) async {
    final mockCallBack = MockCallBack();
    const key = Key('Register_Btn');
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: YouAppButton(
            key: key,
            onPressed: mockCallBack,
            isEnabled: false,
            child: const Text('Register')),
      ),
    ));

    expect(find.byKey(key), findsOneWidget);
    await tester.tap(find.byKey(key));
    verifyNever(mockCallBack());
  });

  testWidgets('should display correct gradien when button is enable',
      (tester) async {
    const key = Key('Register_Btn');

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: YouAppButton(
            key: key,
            onPressed: () {},
            isEnabled: true,
            child: const Text('Register')),
      ),
    ));

    final container = tester.widget<Container>(
        find.descendant(of: find.byKey(key), matching: find.byType(Container)));

    final boxDecoration = container.decoration as BoxDecoration;
    final gradient = boxDecoration.gradient as LinearGradient;

    expect(gradient.colors, [
      YouAppColor.disableBtnColor,
      YouAppColor.disableBtnOneColor,
    ]);
  });


  testWidgets('should display correct gradient when button is disabled',
        (WidgetTester tester) async {
      const key = Key('Register_Btn');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YouAppButton(
              key: key,
              onPressed: () {},
              isEnabled: false,
              child: const Text('Register'),
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
}
