import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'dart:ui';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? weatherIcon;
  int? temperature;
  int? condition;
  String? cityName;
  String? message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        message = 'Unable to get data';
        cityName = 'Some city';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weather.getMessage(temperature!);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.tealAccent, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          constraints: BoxConstraints.expand(),
          child: Container(
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var weatherData = await weather.getWeatherData();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.teal,
                          shadows: [
                            Shadow(
                                blurRadius: 25.0,
                                offset: Offset(5.0, 5.0),
                                color: Colors.teal.shade200)
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityScreen(),
                            ),
                          );
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          color: Colors.teal,
                          shadows: [
                            Shadow(
                                blurRadius: 25.0,
                                offset: Offset(5.0, 5.0),
                                color: Colors.teal.shade200)
                          ],
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 40,
                                ),
                              ),
                              Text(
                                '$cityName',
                                style: kMessageTextStyle,
                              ),
                            ],
                          ),
                          Image.asset(
                            'weather_icon/$weatherIcon.png',
                            height: 350,
                          ),
                          Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "$message",
                              textAlign: TextAlign.right,
                              style: kMessageTextStyle,
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
        ),
      ]),
    );
  }
}
