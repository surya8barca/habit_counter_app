import 'package:flutter/material.dart';
import 'package:habit_counter/models/habit_model.dart';
import 'package:hive/hive.dart';

class MyListData extends ChangeNotifier {
  final Box<HabitModel> _habitBox = Hive.box('habits');

  void addItem(HabitModel habit) {
    habit.lastUpdatedDate.add(formatDate(DateTime.now()));
    _habitBox.add(habit);
    notifyListeners();
  }

  void removeItem(int index) {
    _habitBox.deleteAt(index);
  }

  List<HabitModel> get habits => _habitBox.values.toList();

  void incrementCount(int index) {
    final habit = _habitBox.getAt(index);
    if (habit != null) {
      if (habit.lastUpdatedDate[habit.lastUpdatedDate.length - 1] ==
          formatDate(DateTime.now())) {
        habit.daysCount[habit.daysCount.length - 1] += 1;
      } else {
        if (habit.habitType == 'daily') {
          habit.daysCount.add(1);
          habit.lastUpdatedDate.add(formatDate(DateTime.now()));
        } else {
          habit.daysCount[0] += 1;
          habit.lastUpdatedDate[0] = formatDate(DateTime.now());
        }
      }
      habit.save();
      notifyListeners();
    }
  }

  void resetCount(int index) {
    final habit = _habitBox.getAt(index);
    if (habit != null) {
      if (habit.habitType != 'daily') {
        habit.daysCount[0] = 0;
        habit.lastUpdatedDate[0] = formatDate(DateTime.now());
      }
    }
    habit?.save();
    notifyListeners();
  }

  void addStaticData() {
    for (var habit in test_data) {
      _habitBox.add(habit);
      notifyListeners();
    }
  }

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  List<HabitModel> test_data = [
    HabitModel(habitType: 'daily', habitDesc: 'staticData', daysCount: [
      2,
      3,
      4,
      1,
      4,
      5,
      2,
      2,
      5
    ], lastUpdatedDate: [
      '08/06/2025',
      '09/06/2025',
      '10/06/2025',
      '11/06/2025',
      '12/06/2025',
      '13/06/2025',
      '14/06/2025',
      '15/06/2025',
      '16/06/2025'
    ])
  ];
}
