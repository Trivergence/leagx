import 'package:leagx/constants/enums.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/dashboard/components/news/components/approvals.dart';
import 'package:leagx/ui/screens/dashboard/components/news/components/feed.dart';
import 'package:leagx/ui/screens/dashboard/components/news/components/my_feed.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import '../../../../util/ui_model/tab_button_model.dart';
import 'components/add_news_widget.dart';

class NewsScreen extends StatefulWidget {
  final UserType userType;
  const NewsScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<TabButtonModel> listOfTabs = [
    TabButtonModel(loc.dashboardNewsTxtFeed, 0),
    TabButtonModel(loc.dashboardNewsTxtMyFeed, 1),
    TabButtonModel(loc.dashboardNewsTxtApprovals, 2)
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (widget.userType != UserType.user)
              HeaderWidget(
                  totalTabs: widget.userType == UserType.expert ? 2 : 3,
                  selectedIndex: index,
                  listOfTabs: listOfTabs,
                  onTabChanged: (selectedIndex) {
                    setState(() {
                      index = selectedIndex!;
                    });
                  }),
            index == 0
                ? const Feed()
                : index == 1
                    ? const MyFeed()
                    : index == 2
                        ? const Approvals()
                        : const Feed()
          ],
        ),
        if (widget.userType != UserType.user)
          AddNewsWidget(
            onAddPressed: () => Navigator.of(context).pushNamed(Routes.addNews),
          )
      ],
    );
  }
}
