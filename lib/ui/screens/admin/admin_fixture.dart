import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_border_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminFixtureScreen extends StatelessWidget {
  const AdminFixtureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.adminFixtureTxtFixtures,
      ),
      body: SingleChildScrollView(
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
                  TextWidget(
                      text: loc.adminFixtureTxtLeagues,
                      fontWeight: FontWeight.w700),
                  UIHelper.verticalSpaceSmall,
                  SizedBox(
                    height: 40.0,
                    width: SizeConfig.height * 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GradientBorderWidget(
                            width: 40.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(5.0),
                            isCircular: true,
                            // imageUrl: Strings().placeHolderUrl,
                            imageAsset: Assets.arsFlag,
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
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: loc.adminFixtureTxtUpcomingMatches,
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
                    },
                  ),
                  FixtureWidget(
                    leagueName: 'UEFA Champion League',
                    teamOneFlag: Assets.ufcFlag,
                    teamOneName: 'UFC',
                    teamOneScore: "3",
                    teamTwoFlag: Assets.arsFlag,
                    teamTwoName: 'ARS',
                    teamTwoScore: "5",
                    isLive: true,
                    liveTime: '00:45:35',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
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
                      Navigator.pushNamed(context, Routes.adminFixtureDetail);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
