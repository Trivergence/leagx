import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/divider_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/header_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../util/size/size_config.dart';
import '../../util/ui_model/tab_button_model.dart';
import '../../widgets/icon_container.dart';
import 'components/detail_tile.dart';
import 'components/score_chip.dart';
import 'match/components/live_match_widget.dart';
import 'match/match_view.dart';
import 'players/players_view.dart';

class FixtureDetails extends StatefulWidget {
  const FixtureDetails({ Key? key }) : super(key: key);

  @override
  State<FixtureDetails> createState() => _FixtureDetailsState();
}

class _FixtureDetailsState extends State<FixtureDetails> {
  List<TabButtonModel> listOfTabs = [
    TabButtonModel('MATCH', 0),
    TabButtonModel('PLAYERS', 1),
    TabButtonModel('NEWS', 2)
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(title: 'UEFA Champion League',
      trailing: const Padding(
        padding:  EdgeInsets.only(right:15.0),
        child:  CircleAvatar(radius: 8,
        backgroundColor: AppColors.colorGreen,),
      ),
    ),
    body: Column(
      children: [
        HeaderWidget(totalTabs: 3,
        selectedIndex: index,
        listOfTabs: listOfTabs,
        onTabChanged: (selectedIndex) {
          setState(() {
            index = selectedIndex!;
          });
        }),
        
       index == 0 ? MatchView()
       : index == 1 ? PlayersView() : SizedBox.shrink(),
    ],),
    );
  }
}
