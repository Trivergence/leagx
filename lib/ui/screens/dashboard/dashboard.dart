import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/constants/enums.dart';
import 'package:leagx/ui/screens/dashboard/components/home/home.dart';
import 'package:leagx/ui/screens/dashboard/components/leader/leader.dart';
import 'package:leagx/ui/screens/dashboard/components/news/news.dart';
import 'package:leagx/ui/screens/drawer/drawer_screen.dart';
import 'package:leagx/ui/screens/wallet/wallet_screen.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/size/size_config.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/fixture_view_model.dart';
import 'package:leagx/view_models/wallet_view_model.dart';
import 'package:payments/payments.dart';
import 'package:provider/provider.dart';

import '../../../core/network/internet_info.dart';
import '../../../models/user_summary.dart';
import '../../../view_models/subscription_viewmodel.dart';
import '../../../view_models/dashboard_view_model.dart';
import '../../util/toast/toast.dart';
import '../../widgets/appbar_chip.dart';
import '../../widgets/loading_widget.dart';
import '../base_widget.dart';
import 'components/my_profile/my_profile.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    LeaderScreen(),
    const NewsScreen(
      userType: UserType.admin,
    ),
    const MyProfileScreen(),
    WalletScreen()
  ];

  Future<void> _onItemTapped(int index) async {
    bool isConnected = await InternetInfo.isConnected();
    if(isConnected == true) {
      if (index == 4) {
         if (StripeConfig().getSecretKey.isNotEmpty) {
          if (context.read<DashBoardViewModel>().isInitialized == true) {
            setState(() {
              _selectedIndex = index;
            });
          } else {
            ToastMessage.show(loc.msgPleaseWait, TOAST_TYPE.msg);
          }
        } else {
          ToastMessage.show(loc.errorTryAgain, TOAST_TYPE.msg);
          await context.read<WalletViewModel>().setupStripeCredentials();
        }
      } else {
         setState(() {
          _selectedIndex = index;
        });
      }
    }
   
  }

  @override
  Widget build(BuildContext context) {
    Localization.init(context);
    return BaseWidget<DashBoardViewModel>(
        create: false,
        model: context.read<DashBoardViewModel>(),
        onModelReady: (DashBoardViewModel dashboardModel) {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            bool isConnected = await InternetInfo.isConnected();
            if (isConnected == true) {
              await dashboardModel.getData(context);
              await context.read<SubscriptionViewModel>().getSubscriptionPlans();
              await context.read<SubscriptionViewModel>().getLeagues();
              await context.read<FixtureDetailViewModel>().getUserPredictions();
              await context.read<WalletViewModel>().setupStripeCredentials();
              await context.read<DashBoardViewModel>().getPaymentCredentials(context);
              await context.read<WalletViewModel>().getUserPaymentMethods();
              if (StripeConfig().getSecretKey.isEmpty) {
                await context.read<WalletViewModel>().setupStripeCredentials();
              }
              context.read<DashBoardViewModel>().initializationComplete();
            }
          });
        },
        builder: (context, DashBoardViewModel dashboardModel, _) {
          UserSummary? _userSummary = context.select<DashBoardViewModel, UserSummary?>(
              (dasboardModel) => dasboardModel.userSummary);
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
              appBar: AppBarWidget(
                isIcon: true,
                isDrawer: true,
                trailing: [
                  AppBarChip(
                    totalValue: _userSummary != null ? _userSummary.remainingPredictions.toString() : "0",
                    leadingIcon: Assets.icBullsEye,
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
                    iconAsset: Assets.icHome,
                    activeIconAsset: Assets.icHomeFill
                  ),
                  _bettingNavBarItem(
                    title: loc.dashboardBtnLeader,
                    iconAsset: Assets.icExperts,
                    activeIconAsset: Assets.icExpertsFill
                  ),
                  _bettingNavBarItem(
                    title: loc.dashboardBtnNews,
                    iconAsset: Assets.icNews,
                    activeIconAsset: Assets.icNewsFill
                  ),
                  _bettingNavBarItem(
                    title: loc.dashboardBtnSetting,
                    iconAsset: Assets.icMyProfile,
                    activeIconAsset: Assets.icMyProfileFill
                  ),
                  _bettingNavBarItem(
                    title: loc.dashboardBtnWallet,
                    iconAsset: Assets.icWallet,
                    activeIconAsset: Assets.icWalletFill
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,
              ),
            ),
          );
        });
  }

  BottomNavigationBarItem _bettingNavBarItem(
          {required String title, 
          required String iconAsset,
          required String activeIconAsset,
          }) =>
      BottomNavigationBarItem(
        backgroundColor: AppColors.colorBackground,
        label: '',
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconAsset, height: 18,
              color: AppColors.colorCyan40,
            ),
            UIHelper.verticalSpace(8.0),
            TextWidget(
              text: title,
              textSize: 13,
              color: AppColors.colorCyan40,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              activeIconAsset,
              color: AppColors.colorCyan,
              height: 18),
            UIHelper.verticalSpace(8.0),
            TextWidget(
              text: title,
              textSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.colorCyan,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}


