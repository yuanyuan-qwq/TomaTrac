import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../Controller/API.dart';
import '../../../models/FuzzyRuleWeather.dart';
import '../components/weather_item.dart';
import '../constants.dart';
import 'detail_page.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Constants _constants = Constants();

  String location = ''; //Default location
  String weatherIcon = 'heavycloud.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int AVGhumidity = 0;
  int AVGtemperature = 0;
  int AVGwindSpeed = 0;
  //int cloud = 0;
  int chanceOfRain = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';

  bool isLoading = true;

  void fetchWeatherData() async {
    EasyLoading.show(status: 'Loading'); // Show loading indicator

    // Request location permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        double latitude = position.latitude;
        double longitude = position.longitude;

        final searchWeatherAPI =
            'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=3&aqi=no&alerts=no';

        var searchResult = await http.get(Uri.parse(searchWeatherAPI));

        final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data',
        );

        var locationData = weatherData["location"];
        var currentWeather = weatherData["current"];
        setState(() {
          // Update weather data
          location = locationData["name"];
          var parsedDate = DateTime.parse(locationData["localtime"].substring(0, 10));
          var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
          currentDate = newDate;

          currentWeatherStatus = currentWeather["condition"]["text"];
          weatherIcon = currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
          temperature = currentWeather["temp_c"].toInt();
          windSpeed = currentWeather["wind_kph"].toInt();
          humidity = currentWeather["humidity"].toInt();

          AVGwindSpeed = weatherData["forecast"]["forecastday"][0]["day"]["maxwind_kph"].toInt();
          AVGhumidity = weatherData["forecast"]["forecastday"][0]["day"]["avghumidity"].toInt();
          AVGtemperature = weatherData["forecast"]["forecastday"][0]["day"]["avgtemp_c"].toInt();
          chanceOfRain = weatherData["forecast"]["forecastday"][0]["day"]["daily_chance_of_rain"].toInt();

          // Update forecast data
          dailyWeatherForecast = weatherData["forecast"]["forecastday"];
          hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];

          isLoading = false;
          EasyLoading.dismiss(); // Dismiss loading indicator
        });
      } catch (e) {
        // Handle exceptions
        EasyLoading.showError('Failed to get location', dismissOnTap: true);
      }
    } else {
      EasyLoading.showError('Location permission not granted', dismissOnTap: true);
    }
  }

  @override
  void initState() {
    fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 239, 245),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              color: _constants.primaryColor.withOpacity(.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 8),
                    height: size.height * .73,
                    decoration: BoxDecoration(
                      gradient: _constants.linearGradientBlue,
                      boxShadow: [
                        BoxShadow(
                          color: _constants.primaryColor.withOpacity(.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/Weather/map.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          child: Image.asset("assets/Weather/" + weatherIcon),
                        ).animate()
                            .fade(duration: 600.ms)
                            .scale(delay: 100.ms),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${temperature.toString()}",
                                    style: TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = _constants.shader,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = _constants.shader,
                              ),
                            ),
                          ],
                        ).animate()
                            .fade(duration: 500.ms)
                            .scale(delay: 100.ms),

                        Text(
                          currentWeatherStatus,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ).animate()
                            .fade(duration: 500.ms,delay: 150.ms),
                        Text(
                          currentDate,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ).animate()
                            .fade(duration: 500.ms,delay: 200.ms),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherItem(
                                value: windSpeed.toInt(),
                                unit: 'km/h',
                                imageUrl: 'assets/Weather/windspeed.png',
                              ).animate()
                            .fade(duration: 500.ms)
                            .scale(delay: 150.ms),
                              WeatherItem(
                                value: humidity.toInt(),
                                unit: '%',
                                imageUrl: 'assets/Weather/humidity.png',
                              ).animate()
                                  .fade(duration: 500.ms)
                                  .scale(delay: 300.ms),
                              WeatherItem(
                                value: chanceOfRain.toInt(),
                                unit: '%',
                                imageUrl: 'assets/Weather/lightrain.png',
                              ).animate()
                                  .fade(duration: 500.ms)
                                  .scale(delay: 400.ms),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Colors.white70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Recommendation:\n${provideCareRecommendations(chanceOfRain, AVGtemperature, AVGhumidity, AVGwindSpeed)}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ).animate()
                              .fade(duration: 500.ms,delay: 150.ms)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: size.height * .20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                            dailyForecastWeather:
                                                dailyWeatherForecast,
                                          ))), //this will open forecast screen
                              child: Text(
                                'Forecasts',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: _constants.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            itemCount: hourlyWeatherForecast.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String currentTime =
                                  DateFormat('HH:mm:ss').format(DateTime.now());
                              String currentHour = currentTime.substring(0, 2);

                              String forecastTime = hourlyWeatherForecast[index]
                                      ["time"]
                                  .substring(11, 16);
                              String forecastHour = hourlyWeatherForecast[index]
                                      ["time"]
                                  .substring(11, 13);

                              String forecastWeatherName =
                                  hourlyWeatherForecast[index]["condition"]
                                      ["text"];
                              String forecastWeatherIcon = forecastWeatherName
                                      .replaceAll(' ', '')
                                      .toLowerCase() +
                                  ".png";

                              String forecastTemperature =
                                  hourlyWeatherForecast[index]["temp_c"]
                                      .round()
                                      .toString();
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                margin: const EdgeInsets.only(right: 20),
                                width: 65,
                                decoration: BoxDecoration(
                                    color: currentHour == forecastHour
                                        ? Colors.black54
                                        : _constants.primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 5,
                                        color: _constants.primaryColor
                                            .withOpacity(.2),
                                      ),
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      forecastTime,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: _constants.greyColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/Weather/' +
                                          forecastWeatherIcon,
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$forecastTemperature°C",
                                          style: TextStyle(
                                            color: _constants.greyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
