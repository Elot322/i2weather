import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/data/models/city_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {},
        child: const Text('Press Me!'),
      ),
    );
  }
}
