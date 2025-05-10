import 'package:flutter/material.dart';
import 'package:mark_x/components/bottom_navbar.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/screens/account_screen.dart';
import 'package:mark_x/screens/food_logging_screen.dart';
import 'package:mark_x/screens/habit_screen.dart';
import 'package:mark_x/screens/home_screen.dart';
import 'package:mark_x/screens/jouranl_edit_screen.dart';
import 'package:mark_x/screens/journal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    HabitScreen(),
    JournalScreen(),
    FoodLoggingScreen(),
    AccountScreen(),
    JouranlEditScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: GRBackground.grbackground,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavbar(
        index: _selectedIndex,
        onTabChange: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
      ),
    );
  }
}
