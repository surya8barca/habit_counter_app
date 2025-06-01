import 'package:flutter/material.dart';
import 'package:habit_counter/components/common/custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Builder(
            builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 32),
                  ),
                )));
  }
}
