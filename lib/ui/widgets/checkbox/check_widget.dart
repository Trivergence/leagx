import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class CheckWidget extends StatefulWidget {
  final Function(bool) onChanged;
  const CheckWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CheckWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorCyan, width: 1.0)),
      child: Checkbox(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        checkColor: AppColors.colorCyan,
        fillColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
        side: const BorderSide(color: AppColors.colorCyan, width: 1),
        value: isSelected,
        onChanged: (value) {
          widget.onChanged(value!);
          setState(() {
            isSelected = value;
          });
        },
      ),
    );
  }
}
