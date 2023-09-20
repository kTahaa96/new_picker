part of 'time_picker_cubit.dart';

@immutable
abstract class TimePickerState {}

class TimePickerInitial extends TimePickerState {}
class TimePickerUpdate extends TimePickerState {}
class TimePickerSuccess extends TimePickerState {}
class TimePickerError extends TimePickerState {}
