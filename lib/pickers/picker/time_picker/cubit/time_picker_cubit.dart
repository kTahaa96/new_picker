import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  final DateTime selectedDate;

  TimePickerCubit({required this.selectedDate}) : super(TimePickerInitial());

  static TimePickerCubit of(context) => BlocProvider.of(context);
  late TimeOfDay selectedTime;

  late bool isPM;

  bool showMintsTimer = false;

  void initTimePicker() {
    selectedTime = TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);
    if (selectedTime.hour >= 12) {
      isPM = true;
    } else {
      isPM = false;
    }

    updateHour(newHour: selectedTime.hour);
    updateMinute(newMinute: selectedTime.minute);
    updateView(showMinutesView: false);
  }

  void updateTimeMode({required bool newVal}) {
    isPM = newVal;
    if (!isPM) {
      isPM = false;
      selectedTime = TimeOfDay(hour: selectedTime.hour - 12, minute: selectedTime.minute);
    }
    emit(TimePickerUpdate());
  }

  void updateView({required bool showMinutesView}) {
    showMintsTimer = showMinutesView;
    emit(TimePickerUpdate());
  }

  void updateHour({required int newHour}) {
    selectedTime = TimeOfDay(hour: newHour, minute: selectedTime.minute);
    showMintsTimer = true ;
    emit(TimePickerUpdate());
  }

  void updateMinute({required int newMinute}) {
    selectedTime = TimeOfDay(hour: selectedTime.hour, minute: newMinute);
    emit(TimePickerUpdate());
  }
}
