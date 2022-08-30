import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../util/ui_model/choose_league_model.dart';
import '../../../widgets/gradient_border_button.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';

class LeagueTile extends StatelessWidget {
  
  const LeagueTile({
    Key? key,
    required this.listOfLeagues,required  this.index,
  }) : super(key: key);

  final List<ChooseLeague> listOfLeagues;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal:20, vertical: 16),
        tileColor: AppColors.textFieldColor,
        leading: CircleAvatar(
            backgroundImage: AssetImage(listOfLeagues[index].leagueImage!),
            radius: 25,
          ),
          title: TextWidget(text: listOfLeagues[index].leagueName!),
          trailing: SizedBox(
            height: 26,
            width: 88,
            child: listOfLeagues[index].hasSubscribed! ? MainButton(text: "Subscribed", onPressed: (){},
            fontWeight: FontWeight.w400,
            fontSize: 10,)
            : GradientBorderButton(text: "Subscribe", onPressed: () => Navigator.of(context).pushNamed(Routes.choosePlan,arguments: true), fontWeight: FontWeight.w400,
            fontSize: 10,)),
      ),
    );
  }
}