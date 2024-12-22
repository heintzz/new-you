import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remindme/screens/main_activity.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            useMaterial3: true),
        home: MainActivity());
  }
}
