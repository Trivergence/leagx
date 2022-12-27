import 'package:leagx/ui/screens/admin/admin_fixture_detail/components/coins/fixture_detail_coins.dart';
import 'package:leagx/ui/screens/admin/admin_fixture_detail/components/predictions/fixture_detail_predictions.dart';
import 'package:leagx/ui/widgets/bar/tab_bar/model/tab_bar_item_model.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';

import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/bar/tab_bar/tab_bar_widget.dart';

class AdminFixtureDetailScreen extends StatefulWidget {
  const AdminFixtureDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdminFixtureDetailScreen> createState() => _FixtureDetailScreenState();
}

class _FixtureDetailScreenState extends State<AdminFixtureDetailScreen> {
  bool isCoins = true;
  bool isPredictions = false;
  int _selectedIndex = 0;
  List<TabBarItemModel> tabs = [
    TabBarItemModel(
      'Coins',
      0,
    ),
    TabBarItemModel(
      'Predictions',
      1,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'UFC vs ARS'),
      body: Column(
        children: [
          TabBarWidget(
            totalTabs: 2,
            selectedIndex: _selectedIndex,
            tabs: tabs,
            onTabChanged: (index) {
              setState(() {
                _selectedIndex = index!;
              });
            },
          ),
          // FixtureDetailTabbar(
          //   onCoinsTapped: () {
          //     setState(() {
          //       isCoins = true;
          //       isPredictions = false;
          //     });
          //   },
          //   onPredictionsTapped: () {
          //     setState(() {
          //       isCoins = false;
          //       isPredictions = true;
          //     });
          //   },
          // ),
          _selectedIndex == 0
              ? FixtureDetailCoinsScreen()
              : const FixtureDetailPredictionScreen()
        ],
      ),
    );
  }
}
