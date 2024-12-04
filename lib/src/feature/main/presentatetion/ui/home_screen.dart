import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi_projecect/src/feature/main/presentatetion/bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Введите город',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final city = _cityController.text.trim();
                    if (city.isNotEmpty) {
                      context.read<WeatherBloc>().add(FetchWeather(city));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Введите название города')),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.weather.cityName,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          '${state.weather.temperature.round()}°C',
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          state.weather.mainCondition,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(
                      child: Text(
                        'Ошибка: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Введите название города.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
