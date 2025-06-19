import 'package:flutter/material.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';
import 'package:habit_counter/models/habit_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class OverallHabitAnalytics extends StatefulWidget {
  const OverallHabitAnalytics({super.key, required this.habit});
  final HabitModel habit;

  @override
  State<OverallHabitAnalytics> createState() => _OverallHabitAnalyticsState();
}

class _OverallHabitAnalyticsState extends State<OverallHabitAnalytics> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.1;
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    List<DateTime> dateList = widget.habit.lastUpdatedDate
        .map((str) => formatter.parse(str))
        .toList();

    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: Text(
                widget.habit.habitDesc,
                style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: SfCalendar(
                  view: CalendarView.month,
                  backgroundColor: colorScheme.background,
                  todayHighlightColor: colorScheme.primary,
                  todayTextStyle: TextStyle(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  headerStyle: CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  monthViewSettings: const MonthViewSettings(
                    dayFormat: 'EEE',
                    numberOfWeeksInView: 6,
                    showTrailingAndLeadingDates: false,
                    showAgenda: false,
                  ),
                  monthCellBuilder:
                      (BuildContext context, MonthCellDetails details) {
                    final cellDate = DateTime(details.date.year,
                        details.date.month, details.date.day);

                    final isMarked = dateList.contains(cellDate);

                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isMarked)
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                          Text(
                            details.date.day.toString(),
                            style: TextStyle(
                              color: isMarked
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
