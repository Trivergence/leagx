import 'package:leagx/ui/screens/notification/components/notification_tile.dart';
import 'package:leagx/ui/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Notification',
      ),
      body: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return NotificationTile(
            firstText: 'Barcelona win the match and You have',
            secondText: 'Earned 100 points',
            time: '2 hours ago',
          );
        },
      ),
    );
  }
}
