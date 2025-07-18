import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_cellula/core/constants/strings/constants.dart';
import 'package:weather_app_cellula/features/weather/data/weather_model.dart';

class WeatherService {
  final String baseUrl = 'http://api.weatherapi.com/v1';
  Future<List<WeatherModel>> getWeather({required String cityName}) async {
    final Uri url = Uri.parse(
      '$baseUrl/forecast.json?key=$weatherApiKey&q=$cityName&days=3&aqi=no&alerts=no',
    );

    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      try {
        final data = jsonDecode(response.body);
        final errorMsg = data['error']['message'] ?? 'Something went wrong';
        throw Exception(errorMsg);
      } catch (_) {
        throw Exception('Failed to load weather data');
      }
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    final List forecastDays = data['forecast']['forecastday'];

    return forecastDays
        .map<WeatherModel>((dayJson) => WeatherModel.fromJson(dayJson))
        .toList();
  }
}
