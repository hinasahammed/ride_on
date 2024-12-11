import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ride_on/view/allTrips/all_trips.dart';
import 'package:ride_on/view/home/home_view.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const HomeView(),
          const AllTrips(),
          Container(
            color: Colors.red,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GNav(
          selectedIndex: currentIndex,
          color: theme.colorScheme.primary,
          activeColor: theme.colorScheme.onPrimary,
          tabBackgroundColor: theme.colorScheme.primary,
          gap: 8,
          padding: const EdgeInsets.all(12),
          onTabChange: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
