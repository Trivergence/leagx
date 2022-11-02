import 'package:leagx/models/choose_plan_args.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/gradient/gradient_border_button.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';

class LeagueTile extends StatefulWidget {
  const LeagueTile({
    Key? key,
    required this.leagueId,
    required this.imgUrl,
    required this.leagueTitle,
    required this.hasSubscribed
  }) : super(key: key);
  final String leagueId;
  final String imgUrl;
  final String leagueTitle;
  final bool hasSubscribed;

  @override
  State<LeagueTile> createState() => _LeagueTileState();
}

class _LeagueTileState extends State<LeagueTile> {
  String? leagueTitle;
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading ? Padding(
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
        title: TextWidget(text: leagueTitle!),
        trailing: SizedBox(
            height: 26,
            width: 88,
            child: widget.hasSubscribed
                ? MainButton(
                    text: loc.chooseLeagueBtnSubscribed,
                    onPressed: () {},
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  )
                : GradientBorderButton(
                    text: loc.chooseLeagueBtnSubscribe,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(Routes.choosePlan, arguments: ChoosePlanArgs(leagueId: widget.leagueId, leagueImg: widget.imgUrl, leagueTitle: leagueTitle!)),
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  )),
      ),
    )
    : const ShimmerWidget(height: 100)
    ;
  }

  Future<void> translateData() async {
    leagueTitle = await TranslationUtility.translate(widget.leagueTitle);
    isLoading = false;
    setState(() {
    });
  }
}
