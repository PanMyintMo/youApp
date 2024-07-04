import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/auth_bloc/login_bloc.dart';
import 'package:youapp/profile/bloc/profile_bloc.dart';
import 'package:youapp/register/auth_bloc.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/app_logger.dart';

class YouApp extends StatelessWidget {
  const YouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          logger.d("Easy Hreeee");
          return EasyLoading.init()(context, child);
        },
        debugShowCheckedModeBanner: false,
        title: 'YouApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
          primaryColor: YouAppColor.mainColor,
          fontFamily: 'Gilroy',
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}

void main() {
  runApp(const YouApp());
}
