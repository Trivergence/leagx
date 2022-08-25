import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/routes/routes.dart';
import 'package:bailbooks_defendant/ui/screens/admin/components/admin_tab_bar.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/home/components/analytics_widget.dart';
import 'package:bailbooks_defendant/ui/util/ui/ui_helper.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/main_button.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminScreen extends StatefulWidget {

  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool isTodayTapped = true;
  bool isWeeklyTapped = false;
  bool isMonthlyTapped = false;
  final List<SubscriberSeries> data = [
    SubscriberSeries(
      year: "2008",
      subscribers: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2009",
      subscribers: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2010",
      subscribers: 40,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2011",
      subscribers: 60,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2012",
      subscribers: 80,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2013",
      subscribers: 100,
      barColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
    SubscriberSeries(
      year: "2014",
      subscribers: 120,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2015",
      subscribers: 140,
      barColor: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Admin',
      ),
      body: Column(
        children: [
          AdminTabBar(
            onTodayTap: (){},
            onWeeklyTap: (){},
            onMonthlyTap: (){},
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const AnalyticsWidget(
                    firstLabel: 'Predictions',
                    firstValue: '40',
                    secondLabel: 'Purchases',
                    secondValue: '30',
                    thirdLabel: 'Withraw',
                    thirdValue: '10',
                  ),
                  UIHelper.verticalSpace(45.0),
                  SizedBox(
                    height: 200,
                    child: Image.asset(Assets.imgChart),
                    // child: charts.BarChart(series, animate: true),
                  ),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Flexible(
                        child: MainButton(
                          text: 'Fixtures',
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.adminFixtureDetail);
                          },
                          gradient: AppColors.orangishGradient,
                        ),
                      ),
                      UIHelper.horizontalSpaceMedium,
                      Flexible(
                        child: MainButton(
                          text: 'Announce',
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.adminAnnounce);
                          },
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  MainButton(
                    text: 'Users',
                    onPressed: () {},
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
}

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {required this.year, required this.subscribers, required this.barColor});
}
