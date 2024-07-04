import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/module/auth/auth_module.dart';
import 'package:youapp/module/profile/profile_module.dart';
import 'package:youapp/routes/youapp_routes.dart';

class AppRouter {
  static void _goToNextPage({
    required String routeName,
    Object? args,
    bool isReplace = false,
    bool isReplaceAll = false,
  }) {
    if (isReplace) {
      Modular.to.pushReplacementNamed(routeName, arguments: args);
    } else if (isReplaceAll) {
      //   logger.e(routeName);
      Modular.to.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: args,
      );
    } else {
      Modular.to.pushNamed(routeName, arguments: args);
    }
  }

  static void changeRoute<M extends Module>(
    String routes, {
    Object? args,
    bool? isReplace,
    bool? isReplaceAll,
    List<String>? interests,
  }) {
    String tempRoute = "";

    switch (M) {
      case AuthModule:
        tempRoute = MainRoutes.auth;
        break;
      case ProfileModule:
        tempRoute = MainRoutes.profile;
        break;
    }
    // logger.e(tempRoute);
    // logger.e("$tempRoute$routes");

    _goToNextPage(
      routeName: "$tempRoute$routes",
      args: args,
      isReplace: isReplace ?? false,
      isReplaceAll: isReplaceAll ?? false,
    );
  }
}
