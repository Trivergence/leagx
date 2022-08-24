import 'package:bailbooks_defendant/ui/screens/admin/components/admin_tabbar_button.dart';
import 'package:flutter/material.dart';

class AdminTabBar extends StatefulWidget {
  final VoidCallback onTodayTap;
  final VoidCallback onWeeklyTap;
  final VoidCallback onMonthlyTap;
  const AdminTabBar({Key? key,required this.onTodayTap,required this.onWeeklyTap,required this.onMonthlyTap}) : super(key: key);

  @override
  State<AdminTabBar> createState() => _AdminTabBarState();
}

class _AdminTabBarState extends State<AdminTabBar> {
  bool isTodayTapped = true;
  bool isWeeklyTapped = false;
  bool isMonthlyTapped = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AdminTabBarButton(
          title: 'today',
          isTapped: isTodayTapped,
          onTap: () {
            setState(() {
              isTodayTapped = true;
              isWeeklyTapped=false;
              isMonthlyTapped=false;
            });
            widget.onTodayTap.call();
          },
        ),
        AdminTabBarButton(
          title: 'weekly',
          isTapped: isWeeklyTapped,
          onTap: () {
            setState(() {
              isTodayTapped = false;
              isWeeklyTapped=true;
              isMonthlyTapped=false;
            });
            widget.onWeeklyTap.call();
          },
        ),
        AdminTabBarButton(
          title: 'monthly',
          isTapped: isMonthlyTapped,
          onTap: () {
            setState(() {
              isTodayTapped = false;
              isWeeklyTapped=false;
              isMonthlyTapped=true;
            });
            widget.onMonthlyTap.call();
          },
        ),
      ],
    );
  }
}
