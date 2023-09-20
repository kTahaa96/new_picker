part of 'picker_cubit.dart';

@immutable
abstract class PickerState {}

class PickerInitial extends PickerState {}

class DateUpdated extends PickerState {}

class TimeUpdated extends PickerState {}

class DateTimeDone extends PickerState {}
