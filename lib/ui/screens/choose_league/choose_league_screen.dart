import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/util/ui_model/choose_league_model.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_button.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';

import 'components/league_tile.dart';

class ChooseLeagueScreen extends StatelessWidget {
  ChooseLeagueScreen({ Key? key }) : super(key: key);

  TextEditingController _searchController = TextEditingController();
  List<ChooseLeague> listOfLeagues = [
    ChooseLeague(leagueImage: Assets.leagueImage1, leagueName: 'FIFA Matches', hasSubscribed: true),
    ChooseLeague(leagueImage: Assets.leagueImage2, leagueName: 'Premier League', hasSubscribed: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Choose a League', trailing: const Padding(
        padding:  EdgeInsets.only(right: 15),
        child: Icon(Icons.notifications_outlined, color: AppColors.colorWhite,),
      ),
     ),
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
       child: Column(children: [
        SizedBox(
          height: 48,
          child: SearchTextField(textController: _searchController,
          hint: 'Search',
          ),
        ),
        UIHelper.verticalSpace(30),
        Expanded(
          child: ListView.builder(
            itemCount: listOfLeagues.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return LeagueTile(listOfLeagues: listOfLeagues, index: index,);
          }),
        )
       ],),
     ),
    );
  }
}

