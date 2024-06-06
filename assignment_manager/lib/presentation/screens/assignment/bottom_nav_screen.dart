import 'package:assignment_manager/presentation/utils/app_colors.dart';
import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:assignment_manager/presentation/screens/assignment/assignment_cancelled_screen.dart';
import 'package:assignment_manager/presentation/screens/assignment/assignment_completed_screen.dart';
import 'package:assignment_manager/presentation/screens/assignment/assignment_overview_screen.dart';
import 'package:assignment_manager/presentation/screens/assignment/assignment_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentSelectedIndex = 0;

  final List<Widget> _screens = [
    const AssignmentScreen(),
    const CompletedScreen(),
    const CancelledScreen(),
    const OverviewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentSelectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Assignments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Canclled'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Overview'),
        ],
      ),
    );
  }
}
