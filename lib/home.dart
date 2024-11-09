import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/models/weather_data_model.dart';
import 'package:weather_app/provider/weather_data_provider.dart';
import 'package:weather_app/services/datasource.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _dataSourceService = Datasource();
  WeatherDataModel? _weather;

  getCurrentWeatherData() async {
    //get current city name
    final cityName = await _dataSourceService.getCurrentCity();
    //get weather for city
    getWeather(cityName);
  }

   Future<void> getWeather(String cityName) async{
    try {
      // Fetch weather data for the city using the provider
      await Provider.of<WeatherDataProvider>(context, listen: false).fetchData(cityName);
    }
    catch (e){
       print('Error fetching weather data: $e');
        showErrorDialog(e.toString());
    }
    // try{
    //   final weather = await _dataSourceService.getWeatherData(city);
    //   setState(() {
    //     _weather = weather;
    //   });
    // }

    // //error handling
    // catch (e) {
    //   showErrorDialog(e.toString());
    // }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  //init state
  @override
  void initState() {
    super.initState();

    getCurrentWeatherData();
  }
  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: borderColor1),
        borderRadius: BorderRadius.circular(50));
    final weatherProvider = Provider.of<WeatherDataProvider>(context);    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [gradient1, gradient2, gradient3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: Column(
            children: [
              //SizedBox for searchbar
              SizedBox(
                height: 50,
                child: TextField(
                  onSubmitted: (value){
                    getWeather(value);
                  },
                  style: const TextStyle(color: primaryTextColor, fontSize: 15),
                  decoration: InputDecoration(
                      hintText: 'Search city',
                      hintStyle: const TextStyle(
                       color: borderColor1
                      ),
                      enabledBorder: textFieldBorder,
                      focusedBorder: textFieldBorder,
                      contentPadding: const EdgeInsets.only(left: 20),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          color: borderColor1,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 30),
              //SizedBox for City Name
              SizedBox(
                height: 50,
                child: Text(weatherProvider.weatherInfo?.cityName ?? " ",
                  style: const TextStyle(
                                      fontSize: 30,
                                      color: primaryTextColor,
                                    )
                ),
              ),
              // Temprature box
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100, 
                        width: 100,
                        child: weatherProvider.weatherInfo?.icon
                        == null ? const Icon(
                          Icons.wb_cloudy,
                          color: borderColor1,
                        ) : Image.network(
                          weatherProvider.weatherInfo!.icon
                        ),
                
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text:  TextSpan(
                              children: [
                                TextSpan(
                                  text: "${weatherProvider.weatherInfo?.currentTemp == null ? "0" : weatherProvider.weatherInfo?.currentTemp.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 70,
                                      color: primaryTextColor,
                                    )
                                  ),
                                const TextSpan(
                                    text: "°",
                                    style: TextStyle(
                                      fontSize: 70,
                                      color: primaryTextColor,
                                      fontFeatures: [
                                        FontFeature.superscripts()
                                      ]
                                    )
                                  ),    
                                  const TextSpan(
                                    text: "C",
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: primaryTextColor,
                                    )
                                  ),
                              ],
                            ),
                          ),
                          RichText(
                             text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Feels like ${weatherProvider.weatherInfo?.feelsLike ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: secondaryTextColor,
                                    )
                                ),
                                const TextSpan(
                                    text: "°",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: secondaryTextColor,
                                    )
                                ),
                                const TextSpan(
                                    text: "c",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: secondaryTextColor,
                                    )
                                  ),
                              ]
                             )
                          ),
                        ],
                      )
                    ],
                  )
                  ),
                //Bottom Box
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryBgColor,
                      border: Border.all(
                        color: boredrColor2,
                        width: 5
                      ),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.air,
                              color: borderColor1,
                            ),
                            title:  const Text(
                                "Wind Speed",
                                style: TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                            trailing: Text(
                                "${weatherProvider.weatherInfo?.windSpeed ?? 0} m/s",
                                style: const TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.dew_point,
                              color: borderColor1,
                            ),
                            title:  const Text(
                                "Humidity",
                                style: TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                            trailing: Text(
                                "${weatherProvider.weatherInfo?.humidity ?? 0}%",
                                style: const TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.cloud,
                              color: borderColor1,
                            ),
                            title:  const Text(
                                "Cloud",
                                style: TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                            trailing: Text(
                                "${weatherProvider.weatherInfo?.clouds ?? 0}%",
                                style: const TextStyle(
                                    fontSize: 15, color: primaryTextColor),
                              ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            ],
          ),
        )),
      ),
    );
  }
}
