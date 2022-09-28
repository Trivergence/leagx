import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

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
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Select Option',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.colorWhite),
          ),
        ),
        InkWell(
          onTap: onCameraClick,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Camera',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        InkWell(
          onTap: onGalleryClick,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Gallery',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
