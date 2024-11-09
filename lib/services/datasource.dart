import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_data_model.dart';
import 'package:http/http.dart' as http;

class Datasource {
  String appId = "cc1fe5072bc1db29c58aae5f096aea78";

  Future<WeatherDataModel> getWeatherData(String cityName) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$appId";
    try {
      final response = await http.get(Uri.parse(url));
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json["cod"] == 200) {
        return WeatherDataModel.fromJson(json);
      } else {
        throw Exception(json["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String>getCurrentCity() async {

    // Get location Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    // Fetch Location
    
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100

      );
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);


    // Convert location to placemarks
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract city name from placemark
    String? city = placemarks[0].locality;
    return city ?? ""; 
  }

}