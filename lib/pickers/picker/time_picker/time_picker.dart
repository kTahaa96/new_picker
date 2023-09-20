import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:picker/pickers/picker/time_picker/cubit/time_picker_cubit.dart';
import 'package:picker/pickers/picker/time_picker/views/custom_hours_picker.dart';
import 'package:picker/pickers/picker/time_picker/views/custom_minuts_picker.dart';

class CustomTimePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(TimeOfDay timeOfDay) onDone;
  final VoidCallback onCancel;

  const CustomTimePicker({
    Key? key,
    required this.selectedDate,
    required this.onDone,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimePickerCubit(selectedDate: widget.selectedDate)..initTimePicker(),
      child: BlocConsumer<TimePickerCubit, TimePickerState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = TimePickerCubit.of(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 84,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.selectedDate.year}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('EE, d MMM,').format(widget.selectedDate),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat("hh:mm").format(DateTime(
                            widget.selectedDate.year,
                            widget.selectedDate.month,
                            widget.selectedDate.day,
                            cubit.selectedTime.hour,
                            cubit.selectedTime.minute,
                          )),
                          style: const TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.updateTimeMode(newVal: false);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "AM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: !cubit.isPM ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () {
                                cubit.updateTimeMode(newVal: true);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "PM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: cubit.isPM ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              cubit.showMintsTimer == true
                  ? CustomMinutsPicker(
                      selectedDate: DateTime(
                        widget.selectedDate.year,
                        widget.selectedDate.year,
                        widget.selectedDate.year,
                        cubit.selectedTime.hour,
                        cubit.selectedTime.minute,
                      ),
                      onCancel: () {
                        cubit.updateView(showMinutesView: false);
                      },
                      onChange: (minute) {
                        log("minute  ${minute}");
                        cubit.updateMinute(newMinute: minute);
                      },
                      onDone: (minute) {
                        cubit.updateMinute(newMinute: minute);
                        widget.onDone(
                          TimeOfDay(
                            hour: cubit.selectedTime.hour,
                            minute: cubit.selectedTime.minute,
                          ),
                        );
                      },
                    )
                  : CustomHourPicker(
                      isPM: cubit.isPM,
                      selectedDate: DateTime(
                        widget.selectedDate.year,
                        widget.selectedDate.month,
                        widget.selectedDate.day,
                        cubit.selectedTime.hour,
                        cubit.selectedTime.minute,
                      ),
                      onCancel: () {
                        cubit.updateView(showMinutesView: false);
                      },
                      onChange: (pickedHour) {
                        log("Hour => $pickedHour ");
                        cubit.updateHour(newHour: pickedHour);
                      },
                      onDone: (pickedHour) {
                        cubit.updateHour(newHour: pickedHour);
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
