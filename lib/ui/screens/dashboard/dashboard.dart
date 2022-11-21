import 'package:flutter/scheduler.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/ui/screens/dashboard/components/fixture/fixture.dart';
import 'package:leagx/ui/screens/dashboard/components/home/home.dart';
import 'package:leagx/ui/screens/dashboard/components/leader/leader.dart';
import 'package:leagx/ui/screens/dashboard/components/news/news.dart';
import 'package:leagx/ui/screens/dashboard/components/setting/setting.dart';
import 'package:leagx/ui/screens/drawer/drawer_screen.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../../models/user_summary.dart';
import '../../../view_models/subscription_viewmodel.dart';
import '../../../view_models/dashboard_view_model.dart';
import '../../widgets/appbar_chip.dart';
import '../../widgets/loading_widget.dart';
import '../base_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    const FixtureScreen(),
    LeaderScreen(),
    const NewsScreen(
      userType: UserType.admin,
    ),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Localization.init(context);
    return BaseWidget<DashBoardViewModel>(
        create: false,
        model: context.read<DashBoardViewModel>(),
        onModelReady: (DashBoardViewModel dashboardModel) {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            // bool isConnected = await InternetInfo.isConnected();
            // if (isConnected == true) {
              await dashboardModel.getData(context, showToast: false);
              await context.read<SubscriptionViewModel>().getSubscriptionPlans(showToast: false);
              await context.read<SubscriptionViewModel>().getLeagues(showToast: false);
              await context.read<FixtureDetailViewModel>().getUserPredictions(showToast: false);
              await context.read<WalletViewModel>().setupStripeCredentials(showToast: false);
              await context.read<DashBoardViewModel>().getPaymentCredentials(context, showToast: false);
              await context.read<WalletViewModel>().getUserPaymentMethods(showToast: false);
              context.read<DashBoardViewModel>().initializationComplete();
            // }
          });
        },
        builder: (context, DashBoardViewModel dashboardModel, _) {
          UserSummary? _userSummary = context.select<DashBoardViewModel, UserSummary?>(
              (dasboardModel) => dasboardModel.userSummary);
          return Scaffold(
            appBar: AppBarWidget(
              isIcon: true,
              isDrawer: true,
              trailing: [
                AppBarChip(
                  totalValue: _userSummary != null ? _userSummary.remainingPredictions.toString() : "0",
                  leadingIcon: Assets.icDartBasket,
                ),
                AppBarChip(
                  totalValue: _userSummary != null
                      ? _userSummary.coinEarned!.round().toString()
                      : "0",
                  leadingIcon: Assets.icCoin,
                ),
              ],
            ),
            drawer: DrawerScreen(),
            body: !dashboardModel.busy ? Container(
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
              child: widgetOptions.elementAt(_selectedIndex),
            ) : const LoadingWidget(),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.colorBackground,
              type: BottomNavigationBarType.fixed,
              items: [
                _bettingNavBarItem(
                  title: loc.dashboardBtnHome,
                  iconData: Icons.home_outlined,
                ),
                _bettingNavBarItem(
                  title: loc.dashboardBtnFixture,
                  iconData: Icons.format_list_bulleted,
                ),
                _bettingNavBarItem(
                  title: loc.dashboardBtnLeader,
                  iconData: Icons.leaderboard,
                ),
                _bettingNavBarItem(
                  title: loc.dashboardBtnNews,
                  iconData: Icons.rss_feed,
                ),
                _bettingNavBarItem(
                  title: loc.dashboardBtnSetting,
                  iconData: Icons.settings,
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          );
        });
  }

  BottomNavigationBarItem _bettingNavBarItem(
          {required String title, required IconData iconData}) =>
      BottomNavigationBarItem(
        backgroundColor: AppColors.colorBackground,
        label: '',
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconWidget(
              iconData: iconData,
              color: AppColors.colorWhite.withOpacity(0.5),
            ),
            UIHelper.verticalSpace(5.0),
            TextWidget(
              text: title,
              textSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.colorWhite.withOpacity(0.5),
            ),
          ],
        ),
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientWidget(
              child: IconWidget(
                iconData: iconData,
                color: AppColors.colorWhite.withOpacity(0.5),
              ),
            ),
            UIHelper.verticalSpace(5.0),
            GradientWidget(
              child: TextWidget(
                text: title,
                textSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.colorWhite.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
}


