import 'package:leagx/ui/widgets/bar/tab_bar/model/tab_bar_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../gradient/gradient_widget.dart';
import '../../text_widget.dart';

class TabBarWidget extends StatelessWidget {
  final List<TabBarItemModel> tabs;
  final int totalTabs;
  final int selectedIndex;
  final Function(int?) onTabChanged;
  const TabBarWidget(
      {Key? key,
      required this.totalTabs,
      required this.selectedIndex,
      required this.tabs,
      required this.onTabChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: totalTabs,
        crossAxisSpacing: 2,
        padding: EdgeInsets.zero,
        children: tabs
            .map(
              (tabItem) => Column(
                children: [
                  InkWell(
                    onTap: () => onTabChanged(tabItem.index),
                    child: Container(
                      width: double.infinity,
                      color: AppColors.textFieldColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: tabItem.index == selectedIndex
                              ? TextWidget(
                                text: tabItem.title!,
                                color: AppColors.colorCyan,
                                fontWeight: FontWeight.bold,
                              )
                              : TextWidget(
                                  text: tabItem.title!,
                                  color: AppColors.colorCyan.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: tabItem.index == selectedIndex
                          ? AppColors.colorCyan
                          : AppColors.textFieldColor,
                    ),
                    height: 2,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
