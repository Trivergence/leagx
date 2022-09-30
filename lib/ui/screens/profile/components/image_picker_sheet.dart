// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';

import '../../../../constants/colors.dart';
import '../../../util/locale/localization.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback onCameraClick;
  final VoidCallback onGalleryClick;
  const ImagePickerSheet({
    Key? key,
    required this.onCameraClick,
    required this.onGalleryClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
         Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            loc.profileProfileInfoUpdateSelectOption,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.colorWhite),
          ),
        ),
        InkWell(
          onTap: onCameraClick,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              loc.profileProfileInfoUpdateCamera,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        InkWell(
          onTap: onGalleryClick,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              loc.profileProfileInfoUpdateGallery,
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        UIHelper.verticalSpaceSmall
      ],
    );
  }
}
