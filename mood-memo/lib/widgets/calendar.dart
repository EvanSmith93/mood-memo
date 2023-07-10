import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/calendar_controller.dart';
import 'package:mood_memo/widgets/calendar_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
        child: SfCalendarTheme(
          data: SfCalendarThemeData(
            headerTextStyle: Theme.of(context).textTheme.titleLarge,
            activeDatesTextStyle: Theme.of(context).textTheme.bodyMedium,
            viewHeaderDayTextStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          child: SfCalendar(
            view: CalendarView.month,
            showNavigationArrow: true,
            maxDate: DateTime.now(),
            selectionDecoration: const BoxDecoration(),
            showDatePickerButton: true,
            onTap: (calendarTapDetails) {
              if (calendarTapDetails.targetElement ==
                  CalendarElement.calendarCell) {
                widget.controller.onTap(calendarTapDetails.date, setState);
              }
            },
            monthViewSettings: MonthViewSettings(
              showTrailingAndLeadingDates: false,
              monthCellStyle: MonthCellStyle(
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            monthCellBuilder:
                (BuildContext buildContext, MonthCellDetails details) {
              return CalendarBox(
                  details: details, controller: widget.controller);
            },
          ),
        ),
      ),
    );
  }
}
