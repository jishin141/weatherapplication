import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/main.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeatherEvent>(getWeather);
  }
  // fetch data from weather api
  FutureOr<void> getWeather(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(
      WeatherLoading(),
    );
    await Location.determinePosition();
    const apiKey = '2e789dd8f96aa9c712c3d7582deada9f';
    try {
      // weather factory comes from weather package
      WeatherFactory weatherFactory = WeatherFactory(
        apiKey,
      );

      Weather weather = await weatherFactory.currentWeatherByLocation(
          event.position.latitude, event.position.longitude);

      emit(
        WeatherSuccessState(weather: weather),
      );
    } catch (e) {
      emit(
        WeatherFailure(),
      );
    }
  }
}
