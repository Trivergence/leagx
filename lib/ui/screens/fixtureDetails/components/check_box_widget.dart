import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class CheckBoxWidget extends StatefulWidget {
  final Function(bool) onPressed;
  const CheckBoxWidget({
    Key? key,required this.onPressed,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration:  BoxDecoration(
      border: Border.all(color: AppColors.colorCyan, width: 1.0)
    ),
      child: Checkbox(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        checkColor: AppColors.colorCyan,
        fillColor: MaterialStateProperty.resolveWith((states) {
            return Colors.transparent;
        }),
        side: const BorderSide(color: AppColors.colorCyan, width: 1),
        value: isSelected, onChanged: null
        // (value) {
        //   widget.onPressed(value!);
        //   setState(() {
        //     isSelected = value;
        //   });
        // }
        ),
    );
  }
}