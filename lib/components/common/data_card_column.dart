import 'package:flutter/material.dart';
import 'package:habit_counter/models/habit_model.dart';

class DataCardColumn extends StatelessWidget {
  const DataCardColumn({
    super.key,
    required this.item,
    required this.titleFontSize,
    required this.screenHeight,
    required this.screenWidth,
    required this.countFontSize,
    required this.extraDetailsFontSize,
  });

  final HabitModel item;
  final double titleFontSize;
  final double screenHeight;
  final double screenWidth;
  final double countFontSize;
  final double extraDetailsFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.habitDesc,
          style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.cyan),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          item.habitType.contains('daily')
              ? 'Today\'s Count: ' +
                  '${item.daysCount.elementAt(item.daysCount.length - 1)}'
              : 'Total Count: ' +
                  '${item.daysCount.elementAt(item.daysCount.length - 1)}',
          style: TextStyle(
            fontSize: countFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          'Last updated: ${item.lastUpdatedDate.isEmpty ? 'Not Available' : item.lastUpdatedDate.elementAt(item.daysCount.length - 1)}',
          style: TextStyle(
            fontSize: extraDetailsFontSize,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
