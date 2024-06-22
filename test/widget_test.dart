import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/auth/login/login.dart';
import 'package:youapp/login/login_bloc.dart';
import 'package:youapp/module/youapp_module.dart';
import 'package:youapp/util/youapp_dynamic_textfield.dart';
import 'package:youapp/youapp.dart';

void main() {
  testWidgets('YouApp widget test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      Modular.init(YouAppModule());
    });
    await tester.pumpWidget(const MaterialApp(
      home: YouApp(),
    ));
    await tester.pumpAndSettle();
    expect(find.byType(YouApp), findsOneWidget);
  });

//login widget test
  testWidgets('finds name field by key', (WidgetTester tester) async {
    //  print('Starting test...');

    await tester.runAsync(() async {
      Modular.init(YouAppModule());
      print('Modular.init complete');
    });

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginWidget(),
        ),
      ),
    );

    // print('Widget pumped');

    await tester.pumpAndSettle();

    //  print('Widget settled');

    // Find the name field by key
    expect(find.byKey(Key('login_header')), findsOneWidget);
  });

  testWidgets('finds buildNameFormField renders correctly',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Modular.init(YouAppModule());
    });
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: youAppTextFormField(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hintText: 'Name',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {})),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);
  });



}
