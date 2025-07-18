import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_app_cellula/features/login_SignIn/widgets/circle_info.dart';
import 'package:weather_app_cellula/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app_cellula/features/weather/cubit/weather_states.dart';

class MainWeatherView extends StatefulWidget {
  const MainWeatherView({super.key});
  static const String routeName = "/main-weather-view";
  @override
  State<MainWeatherView> createState() => _MainWeatherViewState();
}

class _MainWeatherViewState extends State<MainWeatherView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeather("Cairo");
  }

  Future<void> fetchNewCityData(BuildContext context, String value) =>
      context.read<WeatherCubit>().fetchWeather(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1E47),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Ahmed",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: (value) => fetchNewCityData(context, value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: "Search a city..",
                hintStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  } else if (state is WeatherFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is WeatherSuccess) {
                    final weatherList = state.weatherList;
                    final cityName = state.cityName;
                    final todayWeather = weatherList[0];

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Calendar
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF192A56),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(weatherList.length, (
                                index,
                              ) {
                                final day = weatherList[index];
                                final isSelected = index == 0;
                                final dayName =
                                    [
                                      'Sun',
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                    ][day.date.weekday % 7];

                                return Container(
                                  decoration:
                                      isSelected
                                          ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          )
                                          : null,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        dayName,
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        day.date.day.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Weather in $cityName",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Temperature
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 160,
                                height: 160,
                                child: CircularProgressIndicator(
                                  value: todayWeather.temp / 50,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white12,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.blueAccent,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.temperatureFull,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${todayWeather.temp.toStringAsFixed(1)}°C",
                                    style: const TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "Temperature",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleInfo(
                                value: todayWeather.maxTemp.toStringAsFixed(1),
                                label: "Max",
                              ),
                              CircleInfo(
                                value: todayWeather.minTemp.toStringAsFixed(1),
                                label: "Min",
                              ),
                              CircleInfo(
                                value: todayWeather.weatherStateName,
                                label: "Condition",
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Chart
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF192A56),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots:
                                        weatherList.asMap().entries.map((
                                          entry,
                                        ) {
                                          return FlSpot(
                                            entry.key.toDouble(),
                                            entry.value.temp,
                                          );
                                        }).toList(),
                                    isCurved: true,
                                    color: Colors.blueAccent,
                                    barWidth: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF192A56),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "Fav"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Check"),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "Fav"),
        ],
        currentIndex: 2,
        onTap: (_) {},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
