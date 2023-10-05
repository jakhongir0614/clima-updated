import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double longitude;
  late double latitude;
  Future<void> RequestLocation() async {
    print('Requesting location permission...');
    Location request = Location();
    await request.RequestPersmission();
    print('Location permission granted');
  }

  Future<void> GetLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeatherData();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    // Make sure to wait for each asynchronous method to complete before moving to the next one
    initializeWeatherData();
  }

  Future<void> initializeWeatherData() async {
    try {
      await RequestLocation();
      await GetLocationData();
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.tealAccent, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}
