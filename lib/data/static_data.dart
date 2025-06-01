import 'package:habit_counter/models/habit_model.dart';

class MyListData {
  static List<HabitModel> habits = [];

  static void addItem(HabitModel habit) {
    habits.add(habit);
  }

  static void removeItem(int index) {
    habits.removeAt(index);
  }

  static List<HabitModel> getAllHabits() {
    return habits;
  }

  static void incrementCount(int index) {
    habits[index].daysCount++;
  }

  static void clearItems() {
    habits.clear();
  }

}
