import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/font_family.dart';
import 'package:bailbooks_defendant/ui/util/size/size_config.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GradientBorderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final VoidCallback onPressed;
  final bool isCircular;
  final Gradient gradient;
  final IconData? iconData;
  final double? iconSize;
  final String? imageUrl;
  const GradientBorderWidget({
    Key? key,
    this.width,
    this.height,
     this.text,
    required this.onPressed,
    this.isCircular = false,
    this.gradient = AppColors.pinkishGradient,
    this.iconData,
    this.iconSize,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width?? SizeConfig.width * 100,
        height: height ?? 48.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            gradient: gradient,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:isCircular?null: const BorderRadius.all(Radius.circular(5.0))),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorBackground,
            shape: isCircular? BoxShape.circle:BoxShape.rectangle,
          ),
          clipBehavior:Clip.antiAliasWithSaveLayer,
          child: iconData != null
              ? IconWidget(
                  iconData: iconData!,
                  size: iconSize,
                )
              : imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.fill,
                      height: height,
                      width:width,
                      
                    )
                  : text!=null?Center(
                      child: TextWidget(
                        text: text!,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.raleway,
                      ),
                    ):const SizedBox(),
        ),
      ),
    );
  }
}
