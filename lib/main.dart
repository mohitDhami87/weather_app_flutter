import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/provider/weather_data_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Home()
    );
  }
}
