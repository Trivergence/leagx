import 'package:leagx/constants/colors.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FaqTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  const FaqTile({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isShow = !isShow;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: widget.title,
                overflow: TextOverflow.ellipsis,
              ),
              isShow
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.colorPink,
                    )
                  : const IconWidget(
                      iconData: Icons.keyboard_arrow_right,
                    ),
            ],
          ),
        ),
        isShow
            ? TextWidget(
                text: widget.subtitle ?? '',
                color: AppColors.colorGrey,
                textSize: 12.0,
                fontWeight: FontWeight.w300,
              )
            : const SizedBox()
      ],
    );
  }
}
