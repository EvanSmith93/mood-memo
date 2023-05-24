import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/calendar_controller.dart';
import 'package:mood_log/widgets/calendar_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({super.key});

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
        height: MediaQuery.of(context).size.width,
        child: SfCalendar(
          view: CalendarView.month,
          showNavigationArrow: true,
          onTap: (calendarTapDetails) {
            widget.controller.onTap(calendarTapDetails.date, setState);
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