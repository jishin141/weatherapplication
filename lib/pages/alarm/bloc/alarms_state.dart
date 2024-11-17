part of 'alarms_bloc.dart';

sealed class AlarmsState extends Equatable {
  const AlarmsState();

  @override
  List<Object> get props => [];
}

final class AlarmsInitial extends AlarmsState {
 
}
final class DataBaseInitial extends AlarmsState {
    final SharedPreferences pref;

  const DataBaseInitial({required this.pref});
   @override
  List<Object> get props => [pref];
}
class AlarmAddedState extends AlarmsState {
  final String label;
  final DateTime addedDate;
  final SharedPreferences pref;

  const AlarmAddedState(this.pref, {required this.label, required this.addedDate });
   @override
  List<Object> get props => [label,addedDate,pref];
}

class AlarmDeletedState extends AlarmsState {
  
}

class AlarmEditedState extends AlarmsState {}
