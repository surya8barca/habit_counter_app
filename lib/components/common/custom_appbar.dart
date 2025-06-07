// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;

  const CustomAppBar({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      elevation:4,
      actions: [],
      backgroundColor: theme.appBarTheme.backgroundColor ??
          (isDark ? Colors.grey[900] : Colors.white),
      iconTheme: theme.iconTheme,
      title: Text(
        'Habit Count Tracker',
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
          color: theme.appBarTheme.titleTextStyle?.color ??
              (isDark ? Colors.white : Colors.black),
        ),
      ),
      centerTitle: true,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
