import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/features/weather/cubit/weather_states.dart';
import 'package:weather_app_cellula/features/weather/data/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      final weatherList = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherList, cityName));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
