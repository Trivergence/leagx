import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/dot_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/image_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/live_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FixtureWidget extends StatelessWidget {
  final String leagueName;
  final String teamOneFlag;
  final String teamOneName;
  final int? teamOneScore;
  final String teamTwoFlag;
  final String teamTwoName;
  final int? teamTwoScore;
  final String? scheduledTime;
  final String? liveTime;
  final bool isLive;
  final bool withText;
  const FixtureWidget({
    Key? key,
    required this.leagueName,
    required this.teamOneFlag,
    required this.teamOneName,
    this.teamOneScore,
    required this.teamTwoFlag,
    required this.teamTwoName,
    this.teamTwoScore,
    this.scheduledTime,
    this.liveTime,
    this.isLive = false,
    this.withText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          gradient: AppColors.blackishGradient,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: leagueName, textSize: Dimens.textSmall),
                isLive
                    ? const LiveWidget()
                    : withText
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GradientWidget(
                                  child: Icon(Icons.access_time_outlined)),
                              UIHelper.horizontalSpace(4.0),
                              const TextWidget(
                                  text: 'Today, 20:00',
                                  textSize: Dimens.textSmall),
                            ],
                          )
                        : const DotWidget(
                            color: AppColors.colorGrey,
                          )
              ],
            ),
          ),
          Divider(
            color: AppColors.colorWhite.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    ImageWidget(
                      imageUrl: '',
                      placeholder: Assets.ufcFlag,
                    ),
                    TextWidget(text: 'UFC'),
                  ],
                ),
                Image.asset(Assets.vs),
                Row(
                  children: const [
                    ImageWidget(
                      imageUrl: '',
                      placeholder: Assets.arsFlag,
                    ),
                    TextWidget(text: 'ARS'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
