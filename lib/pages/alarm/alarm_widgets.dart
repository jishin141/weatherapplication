import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/pages/alarm/add_alarm_page.dart';
import 'package:weatherapp/pages/alarm/bloc/alarms_bloc.dart';

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({
    super.key,
    required this.height,
    required this.alarmInfo,
    required this.cityNAme,
    required this.temp,
    required this.alarmTime,
  });
  final String alarmTime;
  final double height;
  final String alarmInfo;
  final String cityNAme;
  final String temp;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.06,
        ),
        Text(
          alarmInfo,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(130, 197, 195, 195)),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          width: width,
          decoration: BoxDecoration(color: Color.fromARGB(87, 242, 242, 242)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAlarm(
                          place: cityNAme,
                          temp: temp,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.alarm,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<AlarmsBloc>()
                        .add(DeleteAlarmsEvent(context: context));
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          alarmTime,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
