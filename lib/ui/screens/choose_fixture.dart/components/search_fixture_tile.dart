import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/image_widget.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class SearchFixtureTile extends StatelessWidget {
  const SearchFixtureTile(
      {Key? key,
      required this.leagueId,
      required this.imgUrl,
      required this.leagueTitle,required this.matchId, required this.awayTeamName, required this.homeTeamName,
      })
      : super(key: key);
  final String leagueId;
  final String matchId;
  final String imgUrl;
  final String leagueTitle;
  final String awayTeamName;
  final String homeTeamName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        tileColor: AppColors.textFieldColor,
        leading: CircleAvatar(
          child: ImageWidget(
            imageUrl: imgUrl,
          ),
          backgroundColor: AppColors.textFieldColor,
          radius: 25,
        ),
        title: TextWidget(text: leagueTitle),
        subtitle: const TextWidget(text:"WW-IJ"),
        ),
        
    );
  }
}
