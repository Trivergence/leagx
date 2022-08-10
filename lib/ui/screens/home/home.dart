import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/screens/drawer/drawer_screen.dart';
import 'package:bailbooks_defendant/ui/screens/home/components/analytics_widget.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_border_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/fixture_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isIcon: true,
        isDrawer: true,
        trailing: IconButton(
          icon: const IconWidget(
            iconData: Icons.notifications_outlined,
          ),
          onPressed: () {},
        ),
      ),
      drawer: const DrawerScreen(),
      body: Container(
        width: SizeConfig.width * 100,
        height: SizeConfig.height * 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              Assets.homeBackground,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    gradient: AppColors.blackishGradient,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                        text: 'Leaders', fontWeight: FontWeight.w700),
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
                              imageUrl: 'https://i.pravatar.cc/300',
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
                  children: [
                    const AnalyticsWidget(
                      prediction: 5.5,
                      winnigRatio: 70.1,
                      earnedCoin: 400,
                    ),
                    const TextWidget(
                      text: 'Upcoming Matches',
                      fontWeight: FontWeight.w700,
                    ),
                    FixtureWidget(
                      leagueName: 'UEFA Champion League',
                      teamOneFlag: Assets.ufcFlag,
                      teamOneName: 'UFC',
                      teamTwoFlag: Assets.arsFlag,
                      teamTwoName: 'ARS',
                      isLive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
