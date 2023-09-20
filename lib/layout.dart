import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/bottom_sheet_helper.dart';
import 'package:picker/pickers/picker/date_picker/date_picker_view.dart';
import 'package:picker/pickers/picker/cubit/picker_cubit.dart';
import 'package:picker/pickers/picker/time_picker/time_picker.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickerCubit()..initPicker(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("PICKER"),
        ),
        body: BlocConsumer<PickerCubit, PickerState>(
          listener: (context, state) {
            final cubit = PickerCubit.of(context);
            if (state is DateUpdated) {
              Navigator.pop(context);
              BottomSheetHelper.gShowModalBottomSheet(
                context: context,
                isHidden: true,
                content: CustomTimePicker(
                  onDone: (time) {
                    cubit.updateTime(newVal: time);
                  },
                  onCancel: () {
                    BottomSheetHelper.gShowModalBottomSheet(
                      context: context,
                      isHidden: true,
                      content: DatePickerView(
                        onDone: (selectedDate) {
                          cubit.updateDate(newVal: selectedDate);
                          Navigator.pop(context);
                        },
                        initialDate: DateTime.now().add(Duration(hours: 3)),
                        isRound: false,
                        minDate: cubit.selectedDate,
                      ),
                    );
                  },
                  selectedDate: cubit.selectedDate,
                ),
              );
            }
            if (state is TimeUpdated) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final cubit = PickerCubit.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EE, d MMM, hh:mm a').format(cubit.selectedDate),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 100),
                Center(
                  child: InkWell(
                    onTap: () {
                      BottomSheetHelper.gShowModalBottomSheet(
                        context: context,
                        isHidden: true,
                        content: DatePickerView(
                          onDone: (selectedDate) {
                            cubit.updateDate(newVal: selectedDate);
                          },
                          initialDate: DateTime.now().add(const Duration(hours: 3)),
                          isRound: false,
                          minDate: DateTime.now(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "Set date",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
