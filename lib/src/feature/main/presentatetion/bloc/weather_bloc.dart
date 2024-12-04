

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi_projecect/src/feature/main/data/data_source/weather_api_service.dart';
import 'package:weatherapi_projecect/src/feature/main/domain/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      print('Fetching weather for: ${event.cityName}');
      final weather = await weatherService.getWeather(event.cityName);
      print('Weather fetched: $weather');
      emit(WeatherLoaded(weather));
    } catch (e) {
      print('Error fetching weather: $e');
      emit(WeatherError('Не удалось загрузить данные о погоде. Проверьте название города.'));
    }
  }

}
