import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/fixture/fixture.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/home/home.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/leader/leader.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/news/news.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/setting/setting.dart';
import 'package:bailbooks_defendant/ui/screens/drawer/drawer_screen.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/gradient_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[HomeScreen(), FixtureScreen(),LeaderScreen(), NewsScreen(),SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.colorBackground,
        type: BottomNavigationBarType.fixed,
        items: [
     
          _bettingNavBarItem(title: 'Home', iconData: Icons.home_outlined),
          _bettingNavBarItem(title: 'Fixture', iconData: Icons.format_list_bulleted),
          _bettingNavBarItem(title: 'Leader', iconData: Icons.leaderboard),
          _bettingNavBarItem(title: 'News', iconData: Icons.rss_feed),
          _bettingNavBarItem(title: 'Setting', iconData: Icons.settings,),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
  BottomNavigationBarItem _bettingNavBarItem({required String title,required IconData iconData})=>BottomNavigationBarItem(
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
                  textSize: 12,
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
                    textSize: 8,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
}
