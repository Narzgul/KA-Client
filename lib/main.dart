import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ka_client/api_connection.dart';
import 'package:ka_client/style_components/app_scaffold.dart';

void main() {
  runApp(MyApp());    // start argument in additional run arg: -d chrome --web-browser-flag "--disable-web-security"
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _initAPI();
  }

  void _initAPI() => GetIt.I.registerSingleton<APIConnection>(APIConnection());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KA Scraper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromARGB(255, 181, 233, 65),
          seedColor: const Color.fromARGB(255, 181, 233, 65),
        ),
        useMaterial3: true,
      ),
      home: const AppScaffold(),
    );
  }
}
