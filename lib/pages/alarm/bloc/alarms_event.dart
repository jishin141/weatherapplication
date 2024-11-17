// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'alarms_bloc.dart';

sealed class AlarmsEvent extends Equatable {
  const AlarmsEvent();

  @override
  List<Object> get props => [];
}

class AlarmInitialEvent extends AlarmsEvent {}

class AddAlarmEvent extends AlarmsEvent {
  final BuildContext context;
  final String label;

  const AddAlarmEvent({required this.context, required this.label});

  @override
  List<Object> get props => [context, label];
}

class DataBaseInitEvent extends AlarmsEvent {}

class EditAlarmsEvent extends AlarmsEvent {}

class DeleteAlarmsEvent extends AlarmsEvent {
  final BuildContext context;
 const  DeleteAlarmsEvent({
    required this.context,
  });

    @override
  List<Object> get props => [context];

}

class InitDataBaseEvent extends AlarmsEvent {}
