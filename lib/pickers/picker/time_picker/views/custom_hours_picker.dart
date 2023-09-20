import 'package:flutter/material.dart';
import 'package:picker/pickers/picker/time_picker/consts.dart';
import 'package:picker/pickers/picker/time_picker/views/custom_picker_selector.dart';

class CustomHourPicker extends StatefulWidget {
  final Function(int hour) onDone;
  final Function(int hour) onChange;
  final VoidCallback onCancel;
  final DateTime selectedDate;
  final bool isPM;

  const CustomHourPicker(
      {Key? key,
      required this.onDone,
      required this.onChange,
      required this.onCancel,
      required this.selectedDate,
      required this.isPM})
      : super(key: key);

  @override
  State<CustomHourPicker> createState() => _CustomHourPickerState();
}

class _CustomHourPickerState extends State<CustomHourPicker> {
  late int pickedH;

  void getHoursList() {
    if (widget.selectedDate.hour > 12) {
      setState(() => pickedH = widget.selectedDate.hour - 12);
    } else if (widget.selectedDate.hour == 0) {
      setState(() => pickedH = 12);
    } else {
      setState(() => pickedH = widget.selectedDate.hour);
    }
    print("HOUR  ${pickedH}  ,Origin ==> ${widget.selectedDate.hour} ");

    for (int i = 0; i < Consts.hoursList.length; i++) {
      if (pickedH == Consts.hoursList[i].hour) {
        setState(() {
          Consts.hoursList[i].isSelected = true;
        });
      } else {
        setState(() {
          Consts.hoursList[i].isSelected = false;
        });
      }
    }
  }

  @override
  void initState() {
    getHoursList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(color: Color(0xffEEEEEE), shape: BoxShape.circle),
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(Consts.hoursList.length, (index) {
              return CustomItem(
                textAngle: Consts.hoursList[index].textAngle,
                onSelectHour: () {
                  for (int i = 0; i < Consts.hoursList.length; i++) {
                    setState(() {
                      Consts.hoursList[i].isSelected = false;
                    });
                  }
                  setState(() {
                    Consts.hoursList[index].isSelected = true;
                    pickedH = Consts.hoursList[index].hour;
                  });
                  widget.onChange(pickedH);
                },
                angle: Consts.hoursList[index].angle,
                hour: Consts.hoursList[index].hour,
                isSelected: Consts.hoursList[index].isSelected,
              );
            }),
          ),
        ),
        SizedBox(height: 9),
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
                  " Cancel ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 32),
            InkWell(
              onTap: () {
                if (widget.isPM) {
                  setState(() {
                    widget.onDone(pickedH + 12);
                  });
                } else {
                  setState(() {
                    widget.onDone(pickedH);
                  });
                }
              },
              child: Container(
                width: 60,
                height: 40,
                alignment: Alignment.centerRight,
                child: const Text(
                  " Next ",
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
