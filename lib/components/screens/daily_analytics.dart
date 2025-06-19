import 'package:flutter/material.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';
import 'package:habit_counter/models/habit_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyHabitAnalytics extends StatefulWidget {
  const DailyHabitAnalytics({super.key, required this.habit});

  final HabitModel habit;

  @override
  State<DailyHabitAnalytics> createState() => _DailyHabitAnalyticsState();
}

class _DailyHabitAnalyticsState extends State<DailyHabitAnalytics> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.1;

    return Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
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
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Dates',
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                    text: 'Per Day Count',
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  enableAxisAnimation: true,
                  series: <CartesianSeries>[
                    LineSeries(
                      dataSource: List.generate(
                          widget.habit.daysCount.length, (index) => index),
                      xValueMapper: (index, _) =>
                          widget.habit.lastUpdatedDate[index].substring(0, 5),
                      yValueMapper: (index, _) => widget.habit.daysCount[index],
                      markerSettings: MarkerSettings(isVisible: true),
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
