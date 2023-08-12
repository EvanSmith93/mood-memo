import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/calendar_controller.dart';
import 'package:mood_memo/services/date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/rating.dart';

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
    final Rating? rating = widget.controller.getRating(widget.details.date);
    return Container(
            decoration: BoxDecoration(
                color: rating != null
                    ? rating.value.color
                    : !widget.details.date.isAfter(DateTime.now())
                        ? Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[400]
                            : Colors.grey[600]
                        : Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : Colors.grey[800],
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: DateService.isSameDay(
                            widget.details.date, DateTime.now()) && rating == null
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  widget.details.date.day.toString(),
                ),
              ),
            ),
          );
  }
}
