class WeatherDataModel {
  final String cityName;
  final double currentTemp;
  final double feelsLike;
  final double windSpeed;
  final int humidity;
  final int clouds;
  final String icon;

  WeatherDataModel({
    required this.cityName,
    required this.currentTemp,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.clouds,
    required this.icon,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> map) {
    return WeatherDataModel(
      cityName: map["name"],
      currentTemp: map["main"]["temp"],
      feelsLike: map["main"]["feels_like"],
      windSpeed: map["wind"]["speed"],
      humidity: map["main"]["humidity"],
      clouds: map["clouds"]["all"],
      icon:
          "https://openweathermap.org/img/wn/${map["weather"][0]["icon"]}@2x.png",
    );
  }
}