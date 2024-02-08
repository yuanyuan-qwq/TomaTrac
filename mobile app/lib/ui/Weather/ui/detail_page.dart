import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../models/FuzzyRuleWeather.dart';
import '../components/weather_item.dart';
import '../constants.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain = weatherData[index]["day"]["daily_chance_of_rain"].toInt();
      int avgTemperature = weatherData[index]["day"]["avgtemp_c"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'avgTemperature':avgTemperature,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecasts'),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -110,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 350,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [
                              Color(0xffa9c1f5),
                              Color(0xff6696f5),
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 20,
                            child: Image.asset("assets/Weather/" +
                                getForecastWeather(0)["weatherIcon"]),
                            width: 150,
                          ),
                          Positioned(
                              top: 200,
                              left: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/Weather/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/Weather/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/Weather/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 15,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 340,
                            left: 0,
                            child: SizedBox(
                              height: 400,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [

                                  SizedBox(
                                    height: 190,
                                    child: Card(
                                      elevation: 3.0,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getForecastWeather(
                                                      1)["forecastDate"],
                                                  style: const TextStyle(
                                                    color: Color(0xff6696f5),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(1)[
                                                                  "minTemperature"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          '-',
                                                          style: TextStyle(
                                                              color: _constants
                                                                  .greyColor,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFeatures: const [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(1)[
                                                                  "maxTemperature"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          '°C',
                                                          style: TextStyle(
                                                              color: _constants
                                                                  .blackColor,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFeatures: const [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/Weather/' +
                                                          getForecastWeather(
                                                              1)["weatherIcon"],
                                                      width: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      getForecastWeather(
                                                          1)["weatherName"],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getForecastWeather(1)[
                                                                  "chanceOfRain"]
                                                              .toString() +
                                                          "%",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                      'assets/Weather/lightrain.png',
                                                      width: 30,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Text(
                                              "Recommendation:\n${provideCareRecommendations(getForecastWeather(1)["chanceOfRain"], getForecastWeather(1)["avgTemperature"], getForecastWeather(1)["avgHumidity"], getForecastWeather(1)["maxWindSpeed"])}",
                                              style: const TextStyle(
                                                  color: Colors.black87, fontSize: 10),
                                            ),
                                            Text(
                                                ""
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 180,
                                    child: Card(
                                      elevation: 3.0,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getForecastWeather(
                                                      2)["forecastDate"],
                                                  style: const TextStyle(
                                                    color: Color(0xff6696f5),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(2)[
                                                                  "minTemperature"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          '-',
                                                          style: TextStyle(
                                                              color: _constants
                                                                  .greyColor,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFeatures: const [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(2)[
                                                                  "maxTemperature"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          '°C',
                                                          style: TextStyle(
                                                              color: _constants
                                                                  .blackColor,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFeatures: const [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups'),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/Weather/' +
                                                          getForecastWeather(
                                                              2)["weatherIcon"],
                                                      width: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      getForecastWeather(
                                                          2)["weatherName"],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getForecastWeather(2)[
                                                                  "chanceOfRain"]
                                                              .toString() +
                                                          "%",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                      'assets/Weather/lightrain.png',
                                                      width: 30,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Text(
                                              "Recommendation:\n${provideCareRecommendations(getForecastWeather(2)["chanceOfRain"], getForecastWeather(2)["avgTemperature"], getForecastWeather(2)["avgHumidity"], getForecastWeather(2)["maxWindSpeed"])}",
                                              style: const TextStyle(
                                                  color: Colors.black87, fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
