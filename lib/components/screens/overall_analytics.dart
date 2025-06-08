import 'package:flutter/material.dart';
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
    return Container();
  }
}
