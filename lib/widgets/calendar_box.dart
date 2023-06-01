import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/calendar_controller.dart';
import 'package:mood_memo/services/date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarBox extends StatefulWidget {
  final MonthCellDetails details;
  final ColorGridController controller;
  const CalendarBox(
      {super.key, required this.details, required this.controller});

  @override
  State<CalendarBox> createState() => _CalendarBoxState();
}

class _CalendarBoxState extends State<CalendarBox> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.controller.getRating(widget.details.date),
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
                color: snapshot.hasData
                    ? snapshot.data!.value.color
                    : !widget.details.date.isAfter(DateTime.now())
                        ? Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[400]
                            : Colors.grey[600]
                        : Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[300]
                            : Colors.grey[700],
                border: Border.all(
                    color: DateService.isSameDay(
                            widget.details.date, DateTime.now())
                        ? Colors.yellow
                        : Theme.of(context).scaffoldBackgroundColor,
                    width: 0.6)),
            child: Center(
              child: Text(
                widget.details.date.day.toString(),
              ),
            ),
          );
        });
  }
}
