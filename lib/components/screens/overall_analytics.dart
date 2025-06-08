import 'package:flutter/material.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';
import 'package:habit_counter/models/habit_model.dart';

class OverallHabitAnalytics extends StatefulWidget {
  const OverallHabitAnalytics({super.key, required this.habit});
  final HabitModel habit;

  @override
  State<OverallHabitAnalytics> createState() => _OverallHabitAnalyticsState();
}

class _OverallHabitAnalyticsState extends State<OverallHabitAnalytics> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.1;

    return Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Container(
            child: Text("Hey"),
          ),
        ));
  }
}
