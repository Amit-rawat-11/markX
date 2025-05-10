import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mark_x/constant/colors.dart';

class BottomNavbar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTabChange;

  const BottomNavbar({
    super.key,
    required this.index,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: GNav(
        gap: 8,
        tabBorderRadius: 15,
        tabMargin: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: Colors.white,
        color: Colors.grey.shade600,
        tabBackgroundColor: Colors.grey.shade200,
        activeColor: MXColors.primary,
        padding: const EdgeInsets.all(16),
        selectedIndex: index,
        haptic: true,
        onTabChange: onTabChange,

        // tabs: [
        //   GButton(icon: Icons.dashboard, text: 'Home'),
        //   GButton(icon: Icons.book, text: 'Journal'),
        //   GButton(icon: Icons.calendar_month, text: 'Goals'),
        //   GButton(icon: Icons.restaurant_outlined, text: 'Food'),
        //   GButton(icon: Icons.person_2_outlined, text: 'Profile'),
        // ],

        tabs: const [
          GButton(icon: LucideIcons.layoutDashboard),
          GButton(icon: LucideIcons.calendarCheck),
          GButton(icon: LucideIcons.bookOpen),
          GButton(icon: LucideIcons.utensilsCrossed),
          GButton(icon: LucideIcons.user),
        ],
      ),
    );
  }
}


      // tabs: [
      //   GButton(icon: Icons.dashboard, text: 'Home'),
      //   GButton(icon: Icons.book, text: 'Journal'),
      //   GButton(icon: Icons.calendar_month, text: 'Goals'),
      //   GButton(icon: Icons.restaurant_outlined, text: 'Food'),
      //   GButton(icon: Icons.person_2_outlined, text: 'Profile'),
      // ],
     