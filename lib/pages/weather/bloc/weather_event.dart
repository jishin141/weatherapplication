part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [
    
  ];
}

class GetWeatherEvent extends WeatherEvent {
 final Position position;
 const  GetWeatherEvent({required this.position});

  @override
  List<Object> get props => [
    position
  ];
}
