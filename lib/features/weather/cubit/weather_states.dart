import 'package:weather_app_cellula/features/weather/data/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final List<WeatherModel> weatherList;
  final String cityName;

  WeatherSuccess(this.weatherList, this.cityName);
}

class WeatherFailure extends WeatherState {
  final String error;
  WeatherFailure(this.error);
}
