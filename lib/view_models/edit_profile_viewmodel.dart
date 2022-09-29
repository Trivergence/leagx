import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/core/network/api/api_service.dart';
import 'package:leagx/core/network/app_url.dart';
import 'package:leagx/core/sharedpref/shared_preference_helper.dart';
import 'package:leagx/core/viewmodels/base_model.dart';
import 'package:leagx/service/service_locator.dart';
import 'package:leagx/ui/util/loader/loader.dart';
import 'package:leagx/ui/util/locale/localization.dart';

import '../core/network/api/api_models.dart';
import '../core/sharedpref/sharedpref.dart';
import '../models/user/user.dart';
import '../routes/routes.dart';
import '../ui/screens/profile/components/image_picker_sheet.dart';
import '../ui/util/toast/toast.dart';
import '../ui/util/validation/validation_utils.dart';

class EditProfileViewModel extends BaseModel {

  updateProfile({ required BuildContext context,
    required File imgFile,
    required String userName, 
    required String userEmail, 
    required String userPhone, 
    required String userGender}) async {
    User? user = preferenceHelper.getUser();
    if(user != null) {
    Loader.showLoader();
    String fileName = imgFile.path.split('/').last;
      String completeUrl = AppUrl.getUser + user.id.toString();
      FormData formData = FormData.fromMap({
        "user[user_logo]": await MultipartFile.fromFile(imgFile.path, filename: fileName),
        "user[first_name]": userName,
        "user[email]": userEmail,
        "user[phone]": userPhone,
        "user[gender]": userGender,
      });
      User? loginResponce = await ApiService.callPutApi(url: completeUrl,
      body: formData,
      modelName: ApiModels.user,
      );
      if(loginResponce != null) {
        if (ValidationUtils.isValid(loginResponce)) {
          preferenceHelper.saveUser(loginResponce);
          ToastMessage.show(
              loc.profileProfileInfoUpdateSuccesful, TOAST_TYPE.success);
          Loader.hideLoader();
          Navigator.of(context).pop();
        }
      }
    } else {
      Loader.hideLoader();
    }
  }

    updateProfileWoImage(
      {required BuildContext context,
      required String userName,
      required String userEmail,
      required String userPhone,
      required String userGender}) async {
    User? user = preferenceHelper.getUser();
    if (user != null) {
      Loader.showLoader();
      String completeUrl = AppUrl.getUser + user.id.toString();
      FormData formData = FormData.fromMap({
        "user[first_name]": userName,
        "user[email]": userEmail,
        "user[phone]": userPhone,
        "user[gender]": userGender,
      });
      User? loginResponce = await ApiService.callPutApi(
        url: completeUrl,
        body: formData,
        modelName: ApiModels.user,
      );
      if (loginResponce != null) {
        if (ValidationUtils.isValid(loginResponce)) {
          preferenceHelper.saveUser(loginResponce);
          ToastMessage.show(
              loc.profileProfileInfoUpdateSuccesful, TOAST_TYPE.success);
          Loader.hideLoader();
          Navigator.of(context).pop();
        }
      }
    } else {
      Loader.hideLoader();
    }
  }

  Future<CroppedFile?> compressImage(XFile? image) async {
      String type = getFileType(image!.path);
     CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressQuality: 50,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressFormat:
          type == "png" ? ImageCompressFormat.png : ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarColor: Colors.black,
            toolbarTitle: "",
            hideBottomControls: true,
            toolbarWidgetColor: AppColors.primaryColorDark,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "",
          hidesNavigationBar: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
        ),
      ],
    );
    return croppedFile;
  }
  static String getFileType(var file) {
    List<String> pathInList = file!.split(".");
    return pathInList[pathInList.length - 1];
  }

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

