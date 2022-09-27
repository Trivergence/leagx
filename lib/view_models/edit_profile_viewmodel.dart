import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/viewmodels/base_model.dart';

import '../ui/screens/profile/components/image_picker_sheet.dart';

class EditProfileViewModel extends BaseModel {
  pickImage({
    required BuildContext context,
    required Function() onCameraClick,
    required Function() onGalleryClick,
  }) {
    return showModalBottomSheet(
        enableDrag: false,
        context: context,
        backgroundColor: AppColors.colorBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (context) {
          return ImagePickerSheet(onCameraClick: onCameraClick, onGalleryClick: onGalleryClick,);
        });
  }
}

