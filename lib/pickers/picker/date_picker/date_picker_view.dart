import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerView extends StatefulWidget {
  final Function(DateTime value) onDone;
  final bool isRound;
  final DateTime minDate, initialDate;

  const DatePickerView({
    Key? key,
    required this.isRound,
    required this.minDate,
    required this.initialDate,
    required this.onDone,
  }) : super(key: key);

  @override
  State<DatePickerView> createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(16),
        left: Radius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${selectedDate.year}',
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('EE, d MMM,').format(selectedDate),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: SfDateRangePicker(
                    initialDisplayDate: widget.initialDate,
                    initialSelectedDate: widget.initialDate,
                    view: DateRangePickerView.month,
                    monthViewSettings:
                        const DateRangePickerMonthViewSettings(enableSwipeSelection: false),
                    headerStyle: const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                    cancelText: " ",
                    selectionMode: DateRangePickerSelectionMode.single,
                    confirmText: " ",
                    showNavigationArrow: true,
                    todayHighlightColor: Colors.grey[200],
                    enablePastDates: false,
                    toggleDaySelection: true,
                    monthFormat: 'MMM',
                    selectionColor: Colors.black,
                    allowViewNavigation: false,
                    minDate: widget.minDate,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is DateTime) {
                        final DateTime date = args.value;
                        selectedDate = date;
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDone(selectedDate);
                      },
                      child: Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // SizedBox(height: 24),
        ],
      ),
    );
  }
}
