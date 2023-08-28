import 'package:flutter/material.dart';

import './screens/main_screen.dart';

final customColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);

void main() => runApp(const ExpenseApp());

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        appBarTheme: ThemeData().appBarTheme.copyWith(
              backgroundColor: customColorScheme.primary,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "OpenSans",
                fontSize: 22,
              ),
            ),
        colorScheme: customColorScheme,
        useMaterial3: true,
        textTheme: ThemeData(fontFamily: "OpenSans").textTheme.copyWith(
              titleLarge: ThemeData(fontFamily: "OpenSans")
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 22),
              bodyMedium: ThemeData(fontFamily: "OpenSans")
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18),
              bodySmall: ThemeData(fontFamily: "OpenSans")
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14),
              titleMedium: ThemeData(fontFamily: "OpenSans")
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16),
            ),
        cardTheme: ThemeData()
            .cardTheme
            .copyWith(color: customColorScheme.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(), elevation: 3),
        ),
      ),
      title: "Expense App",
      home: MainScreen(),
    );
  }
}
