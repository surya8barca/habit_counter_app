import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  @HiveField(0)
  final String habitDesc;
  @HiveField(1)
  int daysCount;
  @HiveField(2)
  String? lastUpdatedDate;

  HabitModel(
      {required this.habitDesc,
      required this.daysCount,
      required this.lastUpdatedDate});
}
