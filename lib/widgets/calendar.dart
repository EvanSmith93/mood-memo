import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mood_log/controllers/calendar_controller.dart';
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/services/db.dart';
import 'package:mood_log/widgets/calendar_box.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({super.key});

  // color grid controller
  final ColorGridController controller = ColorGridController();

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 400,
        child: SfCalendar(
          view: CalendarView.month,
          showNavigationArrow: true,
          onTap: (calendarTapDetails) {
            widget.controller.onTap(context, calendarTapDetails.date, setState);
          },
          monthViewSettings:
              const MonthViewSettings(showTrailingAndLeadingDates: false),
          monthCellBuilder:
              (BuildContext buildContext, MonthCellDetails details) {
            return CalendarBox(details: details, controller: widget.controller);
          },
        ),
      ),
    );
  }
}
