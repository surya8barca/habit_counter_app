import 'package:flutter/material.dart';
import 'package:habit_counter/models/habit_model.dart';
import 'package:hive/hive.dart';

class MyListData extends ChangeNotifier {
  final Box<HabitModel> _habitBox = Hive.box('habits');

  void addItem(HabitModel habit) {
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
      habit.daysCount += 1;
      habit.save();
      notifyListeners();
    }
  }
}
