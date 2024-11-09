import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_data_model.dart';

void main() {
  group('WeatherData Model Tests', () {
    test('should parse JSON correctly', () {
      // Sample JSON data for testing
      final json = {
        "temperature": 23.5,
        "humidity": 60,
        "description": "Clear sky",
      };

      // Parse JSON into WeatherData object
      final weatherData = WeatherDataModel.fromJson(json);

      // Check if data is parsed correctly
      expect(weatherData.currentTemp, 23.5);
      expect(weatherData.humidity, 60);
      expect(weatherData.cityName, "Ludhiana");
    });

    test('should handle null values gracefully', () {
      // JSON with missing fields
      final json = {
        "currentTemp": null,
        "humidity": 60,
        "cityName": "Ludhiana",
      };

      // Parse JSON into WeatherData object
      final weatherData = WeatherDataModel.fromJson(json);

      // Check if data handles nulls correctly
      expect(weatherData.cityName, isNull);
      expect(weatherData.humidity, 60);
      expect(weatherData.cityName, "Ludhiana");
    });
  });
}