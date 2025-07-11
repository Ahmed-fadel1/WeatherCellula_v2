import 'package:flutter/material.dart';

class MainWeatherView extends StatelessWidget {
  const MainWeatherView({super.key});
  static const routeName = '/main-weather-view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Main Weather View')));
  }
}
