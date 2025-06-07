import 'package:flutter/material.dart';
import 'package:habit_counter/components/alerts/add_habit_alert.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';
import 'package:habit_counter/components/common/data_card_column.dart';
import 'package:habit_counter/service/habitdb_service.dart';
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

  void _addStaticData() {
    mylistdata.addStaticData();
    setState(() {});
  }

  void _showAnalysis(int index) {
    print(mylistdata.habits.elementAt(index).daysCount);
    print(mylistdata.habits.elementAt(index).lastUpdatedDate);
    print(mylistdata.habits.elementAt(index).habitType);
    print(mylistdata.habits.elementAt(index).habitDesc);
  }

  @override
  Widget build(BuildContext context) {
    final habits = mylistdata.habits;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.05;
    final countFontSize = screenWidth * 0.04;
    final extraDetailsFontSize = screenWidth * 0.025;
    final iconButtonSize = screenWidth * 0.06;

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
                    child: Column(
                      children: [
                        Text(
                          'No notes added',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleFontSize,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ElevatedButton(
                            onPressed: _addStaticData,
                            child: Text('Add Static Data'))
                      ],
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DataCardColumn(
                                  item: item,
                                  titleFontSize: titleFontSize,
                                  screenHeight: screenHeight,
                                  countFontSize: countFontSize,
                                  extraDetailsFontSize: extraDetailsFontSize,
                                  screenWidth: screenWidth,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: iconButtonSize,
                                    onPressed: () => _incrementDays(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    iconSize: iconButtonSize,
                                    color: Colors.redAccent,
                                    onPressed: () => _deleteHabit(index),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Transform.scale(
                            scale: 0.75,
                            child: OutlinedButton(
                              onPressed: () => _showAnalysis(index),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.02),
                                ),
                                padding: EdgeInsets.all(screenWidth * 0.02),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Keeps the button compact
                                children: [
                                  Text(
                                    'Analysis',
                                    style: TextStyle(fontSize: countFontSize),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Icon(Icons.analytics),
                                ],
                              ),
                            ),
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
