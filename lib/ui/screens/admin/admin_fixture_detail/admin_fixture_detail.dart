
import 'package:bailbooks_defendant/ui/screens/admin/admin_fixture_detail/components/coins/fixture_detail_coins.dart';
import 'package:bailbooks_defendant/ui/screens/admin/admin_fixture_detail/components/fixture_detail_tabbar.dart';
import 'package:bailbooks_defendant/ui/screens/admin/admin_fixture_detail/components/predictions/fixture_detail_predictions.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';

import 'package:flutter/material.dart';

class AdminFixtureDetailScreen extends StatefulWidget {
  AdminFixtureDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdminFixtureDetailScreen> createState() => _FixtureDetailScreenState();
}

class _FixtureDetailScreenState extends State<AdminFixtureDetailScreen> {
  bool isCoins=true;
  bool isPredictions=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'UFC vs ARS'),
      body: Column(
        children: [
          FixtureDetailTabbar(
            onCoinsTapped: () {
              setState(() {
                isCoins=true;
                isPredictions=false;
              });
            },
            onPredictionsTapped: () {
              setState(() {
                isCoins=false;
                isPredictions=true;
              });
            },
          ),
          isCoins ? FixtureDetailCoinsScreen(): FixtureDetailPredictionScreen()
          
        ],
      ),
    );
  }
}
