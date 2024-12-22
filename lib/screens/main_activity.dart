import 'package:flutter/material.dart';
import 'package:remindme/screens/home/home_page.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.deepPurple,
              ),
              selectedIcon: Icon(Icons.home_rounded),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.star_border_rounded),
              selectedIcon: Icon(Icons.star_rate_rounded),
              label: "Habits")
        ],
      ),
      body: SafeArea(
        child: <Widget>[
          const Home(),
          const Placeholder(),
        ][currentPageIndex],
      ),
    );
  }
}
