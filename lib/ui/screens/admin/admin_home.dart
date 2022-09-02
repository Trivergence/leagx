import 'package:leagx/constants/colors.dart';
import 'package:leagx/routes/routes.dart';
import 'package:leagx/ui/screens/admin/components/admin_tab_bar.dart';
import 'package:leagx/ui/screens/admin/components/legend_widget.dart';
import 'package:leagx/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminHomeScreen> {
  bool isTodayTapped = true;
  bool isWeeklyTapped = false;
  bool isMonthlyTapped = false;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, String>> seriesList = _createSampleData();
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.adminHomeTxtAdmin,
      ),
      body: Column(
        children: [
          AdminTabBar(
            onTodayTap: () {},
            onWeeklyTap: () {},
            onMonthlyTap: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  AnalyticsWidget(
                    firstLabel: loc.adminHomeTxtPredictions,
                    firstValue: '40',
                    secondLabel: loc.adminHomeTxtPurchases,
                    secondValue: '30',
                    thirdLabel: loc.adminHomeTxtWithdraw,
                    thirdValue: '10',
                  ),
                  UIHelper.verticalSpace(45.0),
                  SizedBox(
                    height: 200,
                    // child: Image.asset(Assets.imgChart),
                    child: charts.BarChart(
                      seriesList,
                      animate: true,
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  const LegendWidget(),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Flexible(
                        child: MainButton(
                          text: loc.adminHomeBtnFixtures,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.adminFixture);
                          },
                          gradient: AppColors.orangishGradient,
                        ),
                      ),
                      UIHelper.horizontalSpaceMedium,
                      Flexible(
                        child: MainButton(
                          text: loc.adminHomeBtnAnnounce,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.adminAnnounce);
                          },
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  MainButton(
                    text: loc.adminHomeBtnUsers,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.user);
                    },
                    gradient: AppColors.blueishGradient,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5, charts.ColorUtil.fromDartColor(Colors.blue)),
      new OrdinalSales('2015', 25, charts.ColorUtil.fromDartColor(Colors.blue)),
      new OrdinalSales(
          '2016', 100, charts.ColorUtil.fromDartColor(Colors.blue)),
      new OrdinalSales('2017', 75, charts.ColorUtil.fromDartColor(Colors.blue)),
    ];

    final tableSalesData = [
      new OrdinalSales(
          '2014', 25, charts.ColorUtil.fromDartColor(Colors.orange)),
      new OrdinalSales(
          '2015', 50, charts.ColorUtil.fromDartColor(Colors.orange)),
      new OrdinalSales(
          '2016', 10, charts.ColorUtil.fromDartColor(Colors.orange)),
      new OrdinalSales(
          '2017', 20, charts.ColorUtil.fromDartColor(Colors.orange)),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10, charts.ColorUtil.fromDartColor(Colors.pink)),
      new OrdinalSales('2015', 15, charts.ColorUtil.fromDartColor(Colors.pink)),
      new OrdinalSales('2016', 50, charts.ColorUtil.fromDartColor(Colors.pink)),
      new OrdinalSales('2017', 45, charts.ColorUtil.fromDartColor(Colors.pink)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (OrdinalSales sales, _) => sales.barColor,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (OrdinalSales sales, _) => sales.barColor,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (OrdinalSales sales, _) => sales.barColor,
      ),
    ];
  }
}

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {required this.year, required this.subscribers, required this.barColor});
}

class OrdinalSales {
  final String year;
  final int sales;
  final charts.Color barColor;

  OrdinalSales(this.year, this.sales, this.barColor);
}
