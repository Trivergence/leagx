import 'package:bailbooks_defendant/ui/util/ui_model/tab_button_model.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'gradient_widget.dart';
import 'text_widget.dart';

class HeaderWidget extends StatelessWidget {
  final List<TabButtonModel> listOfTabs;
  final int totalTabs;
  final int selectedIndex;
  final Function(int?) onTabChanged;
  const HeaderWidget({ Key? key, required this.totalTabs, required this.selectedIndex,required this.listOfTabs,required this.onTabChanged }) : super(key: key);

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
      children: listOfTabs.map((tabButton) => Column(
      children: [
        InkWell(
          onTap: () => onTabChanged(tabButton.index),
          child: Container(
          width: double.infinity,
          color: AppColors.textFieldColor,
          child: Center(
            child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: tabButton.index == selectedIndex ? GradientWidget(
            child: TextWidget(text: tabButton.title!,
            color: AppColors.colorGrey,
            fontWeight: FontWeight.w600,),)
            : TextWidget(text: tabButton.title!,
            color: AppColors.colorGrey,
            fontWeight: FontWeight.w600,)
          )),),
        ),
        Container(
          decoration: BoxDecoration(
          gradient: tabButton.index == selectedIndex 
          ? AppColors.pinkishGradient
          : null,
          color: tabButton.index == selectedIndex 
          ? null
          : AppColors.textFieldColor),
          height: 2,
        )
      ],),).toList(),
      ),
    );
  }
}