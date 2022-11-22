import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/presentation/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
