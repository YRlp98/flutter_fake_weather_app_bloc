part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather(this.cityName) : super([cityName]);
}
