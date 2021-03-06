import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fake_weather_app_bloc/model/weather.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState {
    return super.initialState ?? WeatherInitial();
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    try {
      final weather = Weather.fromJson(json);
      return WeatherLoaded(weather);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    if (state is WeatherLoaded) {
      return state.weather.toJson();
    } else {
      return null;
    }
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield WeatherLoading();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
        cityName: cityName,
        temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
      );
    });
  }
}
