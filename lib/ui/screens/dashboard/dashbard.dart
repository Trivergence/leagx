import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/signin.dart';
import 'package:bailbooks_defendant/ui/screens/authentication/signup.dart';
import 'package:bailbooks_defendant/ui/screens/drawer/drawer_screen.dart';
import 'package:bailbooks_defendant/ui/screens/home/home.dart';
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
  static  List<Widget> _widgetOptions = <Widget>[HomeScreen(), SigninScreen(), SignupScreen()];

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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.colorBackground,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            
            icon: Column(
              children: [
                IconWidget(
                  iconData: Icons.home,
                  color: AppColors.colorWhite.withOpacity(0.5),
                ),
                UIHelper.verticalSpace(5.0),
                TextWidget(
                  text: 'Home',
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorWhite.withOpacity(0.5),
                )
              ],
            ),
            activeIcon: Column(
              children: [
                GradientWidget(
                  child: IconWidget(
                    iconData: Icons.home,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
                UIHelper.verticalSpace(5.0),
                GradientWidget(
                  child: TextWidget(
                    text: 'Home',
                    textSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label:'signin',
            icon: Column(
              children: [
                IconWidget(
                  iconData: Icons.home,
                  color: AppColors.colorWhite.withOpacity(0.5),
                ),
                UIHelper.verticalSpace(5.0),
                TextWidget(
                  text: 'Home',
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorWhite.withOpacity(0.5),
                )
              ],
            ),
            activeIcon: Column(
              children: [
                GradientWidget(
                  child: IconWidget(
                    iconData: Icons.home,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
                UIHelper.verticalSpace(5.0),
                GradientWidget(
                  child: TextWidget(
                    text: 'Home',
                    textSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label:'signup',
            icon: Column(
              children: [
                IconWidget(
                  iconData: Icons.home,
                  color: AppColors.colorWhite.withOpacity(0.5),
                ),
                UIHelper.verticalSpace(5.0),
                TextWidget(
                  text: 'Home',
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorWhite.withOpacity(0.5),
                )
              ],
            ),
            activeIcon: Column(
              children: [
                GradientWidget(
                  child: IconWidget(
                    iconData: Icons.home,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
                UIHelper.verticalSpace(5.0),
                GradientWidget(
                  child: TextWidget(
                    text: 'Home',
                    textSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorWhite.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
