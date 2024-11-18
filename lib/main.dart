import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp/pages/weather/weather_screen.dart';
import 'pages/alarm/bloc/alarms_bloc.dart';
import 'pages/weather/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(create: (context) => AlarmsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
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

Future<void> checkAndroidNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    alarmPrint('Requesting notification permission...');
    final res = await Permission.notification.request();
    alarmPrint(
      'Notification permission ${res.isGranted ? '' : 'not '}granted.',
    );
  }
}

Future<void> checkAndroidExternalStoragePermission() async {
  final status = await Permission.storage.status;
  if (status.isDenied) {
    alarmPrint('Requesting external storage permission...');
    final res = await Permission.storage.request();
    alarmPrint(
      'External storage permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  alarmPrint('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    alarmPrint('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    alarmPrint(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}
