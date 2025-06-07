import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  @HiveField(0)
  final String habitDesc;
  @HiveField(1)
  final String habitType;
  @HiveField(2)
  List<int> daysCount;
  @HiveField(3)
  List<String> lastUpdatedDate;

  HabitModel({
    required this.habitType,
    required this.habitDesc,
    required this.daysCount,
    required this.lastUpdatedDate,
  });
}
