import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/features/auth/cubits/login_cubit/login_cubit.dart';
import 'package:weather_app_cellula/core/constants/colors/colors.dart';
import 'package:weather_app_cellula/features/login_SignIn/pages/home_view.dart';
import 'package:weather_app_cellula/features/login_SignIn/pages/log_in_view.dart';
import 'package:weather_app_cellula/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app_cellula/features/weather/data/weather_service.dart';
import 'package:weather_app_cellula/features/weather/presentation/main_weather_view.dart';
import 'package:weather_app_cellula/features/login_SignIn/pages/sign_up_view.dart';
import 'package:weather_app_cellula/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const WeatherAppCellula());
}

class WeatherAppCellula extends StatelessWidget {
  const WeatherAppCellula({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => WeatherCubit(WeatherService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(primaryColor),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            displayLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routes: {
          '/home': (context) => HomeView(),
          '/signup': (context) => SignUpView(),
          '/login': (context) => LogInView(),
          '/main-weather-view': (context) => MainWeatherView(),
        },
        initialRoute: MainWeatherView.routeName,
      ),
    );
  }
}
