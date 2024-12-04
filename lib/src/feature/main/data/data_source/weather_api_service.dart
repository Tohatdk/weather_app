import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapi_projecect/src/feature/main/domain/model/weather_model.dart';

class WeatherApiService {
  static const String BASE_URL = 'http://api.weatherapi.com/v1';
  final String apiKey;

  WeatherApiService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/current.json?key=$apiKey&q=$cityName&lang=ru'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load weather data: ${response.body}');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placeMarks.first.locality ?? '';
  }
}
