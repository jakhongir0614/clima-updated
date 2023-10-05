import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'bb192e270ce8baeb6a438166de6be869';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    print('Getting current location...');
    Location location = Location();
    await location.GetCurrentLocation();
    print(
        'Current location: Latitude ${location.latitude}, Longitude ${location.longitude}');

    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '300';
    } else if (condition < 400) {
      return '400';
    } else if (condition < 600) {
      return '600';
    } else if (condition < 700) {
      return '700';
    } else if (condition < 800) {
      return 'more800';
    } else if (condition == 800) {
      return '800';
    } else if (condition <= 804) {
      return '804';
    } else {
      return '1000';
    }
  }

  String getMessage(int temp) {
    if (temp > 30) {
      return 'Hot';
    } else if (temp > 20) {
      return 'Fair';
    } else if (temp > 10) {
      return 'Cool';
    } else {
      return 'Cold';
    }
  }
}
