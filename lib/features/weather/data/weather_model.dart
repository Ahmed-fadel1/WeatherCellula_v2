class WeatherModel {
  final DateTime date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherStateName;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherStateName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final dayData = json['day'];

    return WeatherModel(
      date: DateTime.parse(json['date']),
      temp: dayData['avgtemp_c'],
      maxTemp: dayData['maxtemp_c'],
      minTemp: dayData['mintemp_c'],
      weatherStateName: dayData['condition']['text'],
    );
  }

  @override
  String toString() {
    return 'WeatherModel(date: $date, temp: $temp°C, max: $maxTemp°C, min: $minTemp°C, condition: $weatherStateName)';
  }
}
