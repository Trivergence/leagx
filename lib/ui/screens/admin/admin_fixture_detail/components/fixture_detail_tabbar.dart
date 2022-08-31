import 'package:bailbooks_defendant/ui/screens/admin/admin_fixture_detail/components/fixture_detail_tabbar_button.dart';
import 'package:bailbooks_defendant/ui/util/locale/localization.dart';
import 'package:flutter/material.dart';

class FixtureDetailTabbar extends StatefulWidget {
  final VoidCallback onCoinsTapped;
  final VoidCallback onPredictionsTapped;
  const FixtureDetailTabbar({
    Key? key,
    required this.onCoinsTapped,
    required this.onPredictionsTapped,
  }) : super(key: key);

  @override
  State<FixtureDetailTabbar> createState() => _FixtureDetailTabbarState();
}

class _FixtureDetailTabbarState extends State<FixtureDetailTabbar> {
  bool isCoinsTapped = true;
  bool isPredictionsTapped = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FixtureDetailTabbarButton(
          title: loc.adminFixtureDetailBtnCoins,
          isTapped: isCoinsTapped,
          onTap: () {
            setState(() {
              isCoinsTapped = true;
            isPredictionsTapped = false;
            widget.onCoinsTapped.call();
            });
          },
        ),
        FixtureDetailTabbarButton(
          title: loc.adminFixtureDetailBtnPredictions,
          isTapped: isPredictionsTapped,
          onTap: () {
            setState(() {
              isCoinsTapped = false;
            isPredictionsTapped = true;
            widget.onPredictionsTapped.call();
            });
          },
        ),
      ],
    );
  }
}
