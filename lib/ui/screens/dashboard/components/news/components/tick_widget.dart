import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';

class TickWidget extends StatefulWidget {
  const TickWidget({
    Key? key,
    required this.isApproved,
  }) : super(key: key);

  final bool isApproved;

  @override
  State<TickWidget> createState() => _TickWidgetState();
}

class _TickWidgetState extends State<TickWidget> {
  late bool approved;
  @override
  void initState() {
    approved = widget.isApproved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          approved = !approved;
        });
      },
      child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
              border: Border.all(
                  color: approved == true
                      ? AppColors.colorCyan
                      : AppColors.colorCyan.withOpacity(0.6),
                  width: 1.5),
              borderRadius: BorderRadius.circular(30)),
          child: Visibility(
            visible: approved,
            child: const Center(
              child: Icon(
                Icons.done,
                size: 13,
                color: AppColors.colorCyan,
              ),
            ),
          )),
    );
  }
}
