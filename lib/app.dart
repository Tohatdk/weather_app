import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi_projecect/src/feature/main/presentatetion/bloc/weather_bloc.dart';
import 'package:weatherapi_projecect/src/feature/main/data/data_source/weather_api_service.dart';
import 'package:weatherapi_projecect/src/feature/main/presentatetion/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) {
          final weatherBloc = WeatherBloc(
            WeatherApiService('4f2e6677e1774120b02171808240312'),
          );
          weatherBloc.add(FetchWeather('Омск'));
          return weatherBloc;
        },
        child: HomeScreen(),
      ),
    );
  }
}
