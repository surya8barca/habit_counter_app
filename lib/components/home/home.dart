import 'package:flutter/material.dart';
import 'package:habit_counter/components/alerts/add_habit_alert.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';
import 'package:habit_counter/data/static_data.dart';
import 'package:habit_counter/models/habit_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MyListData mylistdata = MyListData();

  void _deleteHabit(int index) {
    mylistdata.removeItem(index);
    setState(() {});
  }

  void _incrementDays(int index) {
    mylistdata.incrementCount(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final habits = mylistdata.habits;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.05;
    final countFontSize = screenWidth * 0.04;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: habits.isEmpty
          ? SingleChildScrollView(
              key: const ValueKey("empty"),
              child: SizedBox(
                height: screenHeight - kToolbarHeight - 80,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Text(
                      'No notes added',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              key: const ValueKey("list"),
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final item = habits[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.04,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.habitDesc,
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  item.habitType.contains('daily')
                                      ? 'Today\'s Count:' +
                                          '${item.daysCount.elementAt(item.daysCount.length - 1)}'
                                      : 'Total Count:' +
                                          '${item.daysCount.elementAt(item.daysCount.length - 1)}',
                                  style: TextStyle(
                                    fontSize: countFontSize,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  'Last updated: ${item.lastUpdatedDate.isEmpty ? 'Not Available' : item.lastUpdatedDate.elementAt(item.daysCount.length - 1)}',
                                  style: TextStyle(
                                    fontSize: countFontSize,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            iconSize: screenWidth * 0.07,
                            onPressed: () => _incrementDays(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            iconSize: screenWidth * 0.07,
                            color: Colors.redAccent,
                            onPressed: () => _deleteHabit(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddNewHabit.show(context, (description, habitType) {
            mylistdata.addItem(HabitModel(
                habitType: habitType,
                habitDesc: description,
                daysCount: [0],
                lastUpdatedDate: []));
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          size: screenWidth * 0.07,
        ),
      ),
    );
  }
}
