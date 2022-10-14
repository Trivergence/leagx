import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/string_utility.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/dimens.dart';
import '../../../widgets/text_widget.dart';

class ChooseFixtureTile extends StatefulWidget {
  const ChooseFixtureTile(
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
  State<ChooseFixtureTile> createState() => _ChooseFixtureTileState();
}

class _ChooseFixtureTileState extends State<ChooseFixtureTile> {
  String? homeName;
  String? awayName;
  String leagueTitle = "";
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? InkWell(
      onTap: () => Navigator.pop(context, {
        "matchId": widget.matchId,
        "leagueId": widget.leagueId,
        "leagueTitle": leagueTitle
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          tileColor: AppColors.textFieldColor,
          leading: CircleAvatar(
            child: ImageWidget(
              imageUrl: widget.imgUrl,
               placeholder: Assets.icLeague
            ),
            backgroundColor: AppColors.textFieldColor,
            radius: 25,
          ),
          title: TextWidget(text: leagueTitle),
          subtitle: TextWidget(
            text:"$homeName-$awayName",
            textSize: Dimens.textSmall,
            color: AppColors.colorWhite.withOpacity(0.5),
          ),
          ),
          
      ),
    )
    : const ShimmerWidget(height: 100);
  }

  Future<void> translateData() async {
    homeName = await TranslationUtility.translate(
        widget.homeTeamName);
    awayName = await TranslationUtility.translate(
        widget.awayTeamName);
    leagueTitle = await TranslationUtility.translate(widget.leagueTitle);
    isLoading = false;
    setState(() {});
  }
}
