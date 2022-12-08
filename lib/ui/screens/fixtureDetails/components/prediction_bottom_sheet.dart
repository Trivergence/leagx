import 'package:flutter/material.dart';
import 'package:leagx/models/subscribed_league.dart';
import 'package:leagx/models/user_summary.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/toast/toast.dart';
import 'package:leagx/ui/util/utility/translation_utility.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/shimmer_widget.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../core/network/internet_info.dart';
import '../../../../models/dashboard/fixture.dart';
import '../../../util/ui/ui_helper.dart';
import '../../../widgets/gradient/gradient_border_button.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_widget.dart';
import 'score_picker.dart';

class PredictionSheetWidget extends StatefulWidget {
  final Fixture? matchDetails;
  const PredictionSheetWidget({
    Key? key,
    this.matchDetails,
  }) : super(key: key);

  @override
  State<PredictionSheetWidget> createState() => _PredictionSheetWidgetState();
}

class _PredictionSheetWidgetState extends State<PredictionSheetWidget> {
  BuildContext? _context;
  bool firstSelected = false;
  bool secondSelected = false;
  bool isPublic = false;
  int awayScore = 2;
  int homeScore = 1;
  int? leagueId;
  int? expertId;
  String homeTeamName = '';
  String awayTeamName = '';
  bool isLoading = true;

  @override
  void initState() {
    translateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    leagueId = getIntLeageId();
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 26, top: 22),
            width: 30,
            height: 3,
            color: AppColors.colorWhite.withOpacity(0.4),
          ),
          TextWidget(
            text: loc.fixtureDetailsTxtPredictMatchResult,
            color: AppColors.colorPink,
          ),
          UIHelper.verticalSpace(34),
          !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: Column(
                        children: [
                          TextWidget(
                            text: homeTeamName,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ScorePicker(
                          initialScore: 1,
                          isSelected: firstSelected,
                          onChanged: (score) {
                            setState(() {
                              secondSelected = false;
                              firstSelected = true;
                              homeScore = score;
                            });
                          },
                        ),
                        UIHelper.horizontalSpace(2),
                        ImageWidget(
                          height: 30,
                          width: 30,
                          placeholder: Assets.icTeamAvatar,
                          imageUrl: widget.matchDetails!.teamHomeBadge,
                          shouldClip: true,
                        )
                      ],
                    )
                  ],
                )
              : const ShimmerWidget(height: 20),
          UIHelper.verticalSpace(22),
          !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.width * 30,
                      child: Column(
                        children: [
                          TextWidget(
                            text: awayTeamName,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ScorePicker(
                          initialScore: 2,
                          isSelected: secondSelected,
                          onChanged: (score) {
                            setState(() {
                              secondSelected = true;
                              firstSelected = false;
                              awayScore = score;
                            });
                          },
                        ),
                        UIHelper.horizontalSpace(2),
                        ImageWidget(
                          height: 30,
                          width: 30,
                          placeholder: Assets.icTeamAvatar,
                          imageUrl: widget.matchDetails!.teamAwayBadge,
                          shouldClip: true,
                        )
                      ],
                    )
                  ],
                )
              : const ShimmerWidget(height: 20),
          UIHelper.verticalSpace(20),
          // Row(
          //   children: [
          //     CheckBoxWidget(
          //       onPressed: (isChecked) => isPublic = isChecked,
          //     ),
          //     UIHelper.horizontalSpace(13),
          //     TextWidget(
          //       text: loc.fixtureDetailsTxtMakeMyPredictPublic,
          //     ),
          //   ],
          // ),
          UIHelper.verticalSpace(30),
          MainButton(
            text: loc.fixtureDetailsBtnSubmit,
            onPressed: _predictMatch,
          ),
          UIHelper.verticalSpace(20),
          GradientBorderButton(
            text: loc.fixtureDetailsBtnConsultAdvisor,
            onPressed: _chooseExpert,
          ),
        ],
      ),
    );
  }

  Future<void> _predictMatch() async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (leagueId != null) {
        _context!.read<FixtureDetailViewModel>().savePrediction(
            context: _context!,
            matchId: int.parse(widget.matchDetails!.matchId),
            leagueId: leagueId!,
            homeScore: homeScore,
            awayScore: awayScore,
            awayTeamLogo: widget.matchDetails!.teamAwayBadge,
            homeTeamLogo: widget.matchDetails!.teamHomeBadge,
            expertId: expertId,
            awayTeamName: widget.matchDetails!.matchAwayteamName,
            homeTeamName: widget.matchDetails!.matchHometeamName,
            isPublic: isPublic);
      }
    }
  }

  int? getIntLeageId() {
    List<SubscribedLeague> subscribedLeagues = context
        .read<DashBoardViewModel>()
        .subscribedLeagues
        .where((league) =>
            league.externalLeagueId.toString() == widget.matchDetails!.leagueId)
        .toList();
    if (subscribedLeagues.isNotEmpty) {
      return subscribedLeagues.first.id;
    } else {
      return null;
    }
  }

  Future<void> _chooseExpert() async {
    List<UserSummary> listOfAnalysts =
        _context!.read<FixtureDetailViewModel>().getAnalysts;
    if (listOfAnalysts.isNotEmpty) {
      await Navigator.of(_context!).pushReplacementNamed(Routes.chooseAnalyst,
          arguments: widget.matchDetails);
    } else {
      ToastMessage.show(
          loc.fixtureDetailsMsgAdvisorUnavailable, TOAST_TYPE.msg);
    }
  }

  Future<void> translateData() async {
    String originalCommaText = widget.matchDetails!.matchHometeamName +
        "," +
        widget.matchDetails!.matchAwayteamName;
    String translatedCommaText =
        await TranslationUtility.translate(originalCommaText);
    List<String> listOfValues = [];
    if (translatedCommaText.contains("،")) {
      listOfValues = translatedCommaText.split("،");
    } else {
      listOfValues = translatedCommaText.split(",");
    }
    homeTeamName = listOfValues[0];
    awayTeamName = listOfValues[1];
    isLoading = false;
    setState(() {});
  }
}
