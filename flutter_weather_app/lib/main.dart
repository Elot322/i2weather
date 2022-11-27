import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/app.dart';
import 'package:flutter_weather_app/sevice_locator.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
