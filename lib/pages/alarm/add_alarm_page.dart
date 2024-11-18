import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/pages/alarm/bloc/alarms_bloc.dart';

class AddAlarm extends StatefulWidget {
  final String place;
  final String temp;
  const AddAlarm({super.key, required this.place, required this.temp});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Add Alarm', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Place(
                callback: () {},
                place: widget.place,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'Alarm Label',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please Add Label',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    );
                  } else {
                    context.read<AlarmsBloc>().add(AddAlarmEvent(
                        context: context, label: controller.text));
                  }
                },
                child: const Text('Next'),
              )
            ],
          )
        ],
      ),
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
