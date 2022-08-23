import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/strings.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: AppColors.blackishGradient,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(text: 'Leaders', fontWeight: FontWeight.w700),
                UIHelper.verticalSpaceSmall,
                SizedBox(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GradientBorderWidget(
                          width: 40.0,
                          height: 40.0,
                          isCircular: true,
                          imageUrl: Strings.placeHolderUrl,
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const AnalyticsWidget(
                  firstLabel: 'Predictions',
                  firstValue: '5.5',
                  secondLabel: 'Winning Ratio',
                  secondValue: '70.1',
                  thirdLabel: 'Earned Coin',
                  thirdValue: '400',

                ),
                const TextWidget(
                  text: 'Upcoming Matches',
                  fontWeight: FontWeight.w700,
                ),
                UIHelper.verticalSpaceSmall,
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
                FixtureWidget(
                  leagueName: 'UEFA Champion League',
                  teamOneFlag: Assets.ufcFlag,
                  teamOneName: 'UFC',
                  teamTwoFlag: Assets.arsFlag,
                  teamTwoName: 'ARS',
                  scheduledTime: 'Today, 20:00',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fixtureDetails);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
