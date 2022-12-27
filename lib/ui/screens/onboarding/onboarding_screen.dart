import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/screens/onboarding/components/onboarding_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    Localization.init(context);
    return Scaffold(
      body: Column(
        children: [
          _pageView(),
          _pageIndicators(),
          _button(context),
        ],
      ),
    );
  }

  Widget _pageView() => Flexible(
        child: PageView(
          controller: controller,
          onPageChanged: (index) {},
          children: [
            OnBoardingWidget(
              subtitle: loc.onboardingTxtDesc1,
              imageAsset: Assets.onBoard1,
            ),
            OnBoardingWidget(
              subtitle: loc.onboardingTxtDesc2,
              imageAsset: Assets.onBoard2,
            ),
            OnBoardingWidget(
              subtitle: loc.onboardingTxtDesc3,
              imageAsset: Assets.onBoard3,
            ),
          ],
        ),
      );

  Widget _pageIndicators() => SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: const WormEffect(
          dotHeight: 11.0,
          dotWidth: 11.0,
          spacing: 10.0,
          dotColor: AppColors.colorWhite,
          activeDotColor: AppColors.colorYellow,
        ),
        onDotClicked: (index) => controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        ),
      );
  Widget _button(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 50.0),
        child: MainButton(
          text: loc.onboardingBtnGetStarted,
          onPressed: () {
            locator<SharedPreferenceHelper>().setFirstTime(false);
            Navigator.pushNamed(context, Routes.signin);
          },
        ),
      );
}
