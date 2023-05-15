import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/calendar_controller.dart';
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
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                  color: snapshot.data!.color,
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: Center(
                child: Text(
                  widget.details.date.day.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  color: !widget.details.date.isAfter(DateTime.now())
                      ? Colors.grey[400]
                      : Colors.grey[300],
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: Center(
                child: Text(
                  widget.details.date.day.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          }
        });
  }
}
