import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'picker_state.dart';

class PickerCubit extends Cubit<PickerState> {
  PickerCubit() : super(PickerInitial());

  static PickerCubit of(context) => BlocProvider.of(context);

  late DateTime selectedDate;

  void initPicker() {
    selectedDate = DateTime.now();
  }

  void updateDate({required DateTime newVal}) {
    selectedDate = newVal;
    log("$selectedDate");
    emit(DateUpdated());
  }

  void updateTime({required TimeOfDay newVal}) {
    log("${newVal.hour}");
    log("${newVal.minute}");
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      newVal.hour,
      newVal.minute,
    );
    log(" New Final Date => $selectedDate");
    emit(TimeUpdated());
  }
}
