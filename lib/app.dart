import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/theme.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_app/weather/weather.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key, required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(key: key);

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: WeatherAppScreen(),
      ),
    );
  }
}

class WeatherAppScreen extends StatelessWidget {
  const WeatherAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: color,
            appBarTheme: AppBarTheme(
              toolbarTextStyle: TextStyle(color: Colors.white),
              elevation: 0,
              backgroundColor: color,
              centerTitle: true,
            ),
          ),
          home: WeatherPage(),
        );
      },
    );
  }
}
