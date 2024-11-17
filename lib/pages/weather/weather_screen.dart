import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/pages/alarm/alarm_widgets.dart';
import 'package:weatherapp/pages/alarm/bloc/alarms_bloc.dart';
import 'package:weatherapp/pages/weather/bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    super.key,
  });
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class HelperWidgets {
  static Widget getWeatherIcon(int code, double height) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/images/7.png');
      case >= 300 && < 400:
        return Image.asset(height: height * 0.34, 'assets/images/2.png');
      case >= 500 && < 600:
        return Image.asset(height: height * 0.34, 'assets/images/3.png');
      case >= 600 && < 700:
        return Image.asset(height: height * 0.34, 'assets/images/7.png');
      case >= 700 && < 800:
        return Image.asset(height: height * 0.34, 'assets/images/5.png');
      case == 800:
        return Image.asset(height: height * 0.34, 'assets/images/6.png');
      case > 800 && <= 804:
        return Image.asset(height: height * 0.34, 'assets/images/4.png');
      default:
        return Image.asset(height: height * 0.34, 'assets/images/8.png');
    }
  }
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    BlocProvider.of<AlarmsBloc>(context).add(AlarmInitialEvent());
    if (Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermission();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return FutureBuilder(
      future: Location.determinePosition(),
      builder: (context, snapshot) {
        String cityNAme = '';
        String temp = '';

        if (snapshot.hasData) {
          final Position wp = snapshot.data as Position;

          BlocProvider.of<WeatherBloc>(context).add(
            GetWeatherEvent(position: wp),
          );
        }
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 85, 84, 84),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlocBuilder<AlarmsBloc, AlarmsState>(
                            builder: (context, state) {
                              String alarmInfo = 'NO ALARMS FOUND';
                              String alarmTime = '';
                              if (state is DataBaseInitial) {
                                state.pref.getString('label') == null
                                    ? alarmInfo = 'No Alarms '
                                    : alarmInfo = state.pref
                                        .getString('label')!
                                        .toUpperCase();

                                state.pref.getString('alarmTime') == null
                                    ? alarmTime = ''
                                    : alarmTime = state.pref
                                        .getString('alarmTime')!
                                        .toUpperCase();
                              }
                              if (state is AlarmAddedState) {
                                String? label = state.pref.getString('label');
                                alarmInfo = label!;
                                alarmTime = state.pref.getString('alarmTime')!;
                              }
                              return AlarmWidget(
                                  alarmTime: alarmTime,
                                  height: height,
                                  alarmInfo: alarmInfo,
                                  cityNAme: cityNAme,
                                  temp: temp);
                            },
                          ),
                        ],
                      ),
                      BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (context, state) {
                          if (state is WeatherLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is WeatherSuccessState) {
                            final weather = state.weather;
                            cityNAme = weather.areaName!;
                            temp =
                                weather.temperature!.celsius!.round.toString();
                            return Column(
                              children: [
                                SizedBox(
                                  height: height * 0.25,
                                ),
                                Place(
                                  callback: () {
                                    context.read<WeatherBloc>().add(
                                          GetWeatherEvent(
                                              position:
                                                  snapshot.data as Position),
                                        );
                                  },
                                  place: weather.areaName!,
                                ),
                                HelperWidgets.getWeatherIcon(
                                    weather.weatherConditionCode!, height),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                TemperatureText(
                                  text: state.weather.temperature!.celsius!
                                      .round()
                                      .toString(),
                                ),
                                WeatherDescription(
                                    weather: weather, width: width),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  DateFormat('EEEE M/d/y')
                                      .add_jm()
                                      .format(weather.date!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Place extends StatelessWidget {
  final VoidCallback callback;
  final String place;
  const Place({
    super.key,
    required this.place,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ' $place',
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          IconButton(
            onPressed: callback,
            icon: const Icon(
              Icons.refresh,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class TemperatureText extends StatelessWidget {
  final String text;
  const TemperatureText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text °C',
      style: const TextStyle(
          fontSize: 66, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(height: height * 0.34, 'assets/images/1.png');
  }
}

class Location {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

class WeatherDescription extends StatelessWidget {
  const WeatherDescription({
    super.key,
    required this.weather,
    required this.width,
  });

  final Weather weather;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      weather.weatherDescription!.toUpperCase(),
      style: TextStyle(
          color: Colors.white,
          fontSize: width * 0.044,
          fontWeight: FontWeight.bold),
    );
  }
}
