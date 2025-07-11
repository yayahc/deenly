import 'package:flutter/material.dart';
import 'providers.dart';
import 'init.dart';

Future<void> main() async {
  await initApp();
  runApp(const Providers(isDevMode: true));
}
