import 'package:flutter/material.dart';
import 'package:picker/pickers/picker/time_picker/consts.dart';
import 'package:picker/pickers/picker/time_picker/views/custom_picker_selector.dart';

class CustomMinutsPicker extends StatefulWidget {
  final Function(int minit) onDone;
  final Function(int minit) onChange;
  final DateTime selectedDate;

  final VoidCallback onCancel;

  const CustomMinutsPicker({
    Key? key,
    required this.onDone,
    required this.onChange,
    required this.onCancel,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<CustomMinutsPicker> createState() => _CustomMinutsPickerState();
}

class _CustomMinutsPickerState extends State<CustomMinutsPicker> {
  late int pickedMinut;

  void getHoursList() {
    int hourValue = widget.selectedDate.minute;
    pickedMinut = findHourBetween(Consts.minutsList, hourValue);

    for (int i = 0; i < Consts.minutsList.length; i++) {
      if (pickedMinut == Consts.minutsList[i].hour) {
        setState(() {
          Consts.minutsList[i].isSelected = true;
        });
      } else {
        setState(() {
          Consts.minutsList[i].isSelected = false;
        });
      }
    }
  }

  int findHourBetween(List<TimeGeneralModel> minutsList, int hourValue) {
    minutsList.sort((a, b) => a.hour.compareTo(b.hour));

    for (int i = 0; i < minutsList.length; i++) {
      if (hourValue < minutsList[i].hour) {
        int previousHour = minutsList[i - 1].hour;
        int currentHour = minutsList[i].hour;

        if (hourValue - previousHour <= currentHour - hourValue) {
          return previousHour;
        } else {
          return currentHour;
        }
      }
    }

    return minutsList.last.hour;
  }

  @override
  void initState() {
    getHoursList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(color: Color(0xffEEEEEE), shape: BoxShape.circle),
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(Consts.minutsList.length, (index) {
              return CustomItem(
                textAngle: Consts.minutsList[index].textAngle,
                onSelectHour: () {
                  for (int i = 0; i < Consts.minutsList.length; i++) {
                    setState(() {
                      Consts.minutsList[i].isSelected = false;
                    });
                  }
                  setState(() {
                    Consts.minutsList[index].isSelected = true;
                  });
                  widget.onChange(Consts.minutsList[index].hour);
                },
                angle: Consts.minutsList[index].angle,
                hour: Consts.minutsList[index].hour,
                isSelected: Consts.minutsList[index].isSelected,
              );
            }),
          ),
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                widget.onCancel();
              },
              child: Container(
                width: 60,
                height: 40,
                alignment: Alignment.centerRight,
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.onDone(pickedMinut);
                });
              },
              child: Container(
                width: 60,
                height: 40,
                alignment: Alignment.centerRight,
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
      ],
    );
  }
}
