import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_model.dart';
import 'package:weather_app/services/datasource.dart';

class WeatherDataProvider extends ChangeNotifier {
  WeatherDataModel? _weatherDataModel;

  WeatherDataModel? get weatherInfo => _weatherDataModel;

  Future<void> fetchData(String cityName) async {
    _weatherDataModel = await Datasource().getWeatherData(cityName);
    notifyListeners();
  }
}
