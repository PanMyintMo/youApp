import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/module/youapp_module.dart';
import 'package:youapp/youapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: YouAppModule(), child: const YouApp()));
}
