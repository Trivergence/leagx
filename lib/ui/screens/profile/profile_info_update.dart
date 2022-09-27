import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/update_profile_args.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/dropdown_form_widget.dart';
import 'package:leagx/ui/widgets/gradient/gradient_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/edit_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileInfoUpdateScreen extends StatefulWidget {
  final UpdateProfileArgs payload;

  ProfileInfoUpdateScreen({Key? key, required this.payload}) : super(key: key);

  @override
  State<ProfileInfoUpdateScreen> createState() => _ProfileInfoUpdateScreenState();
}

class _ProfileInfoUpdateScreenState extends State<ProfileInfoUpdateScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  late String selectedGender;

  final ImagePicker _picker = ImagePicker();
  late EditProfileViewModel profileModel;
  CroppedFile? file;

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileModel = context.watch<EditProfileViewModel>();
    selectedGender = "Male";
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBarWidget(
        title: loc.profileProfileInfoUpdateTxtEditProfile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            UIHelper.verticalSpace(40.0),
            Stack(
              children: [
                InkWell(
                  onTap: () => profileModel.pickImage(context: context,
                  onCameraClick: _onCameraClick,
                  onGalleryClick: _onGalleryClick),
                  child: Container(
                    width: 96.0,
                    height: 96.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(file!.path)),
                          fit: BoxFit.fill),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 9.0,
                  right: 9.0,
                  child: GradientWidget(
                    child: Icon(Icons.camera_alt),
                    gradient: AppColors.pinkishGradient,
                  ),
                )
              ],
            ),
            UIHelper.verticalSpace(50.0),
            TextFieldWidget(
              textController: _nameController,
              hint: 'John Smith',
              prefix: const IconWidget(iconData: Icons.account_circle_outlined),
              inputAction: TextInputAction.next,
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _emailController,
              hint: 'abc@xyz.com',
              prefix: const IconWidget(iconData: Icons.drafts_outlined),
              inputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
            ),
            UIHelper.verticalSpace(15.0),
            TextFieldWidget(
              textController: _phoneController,
              hint: '1234567890',
              prefix: const IconWidget(iconData: Icons.smartphone),
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
            ),
            UIHelper.verticalSpace(15.0),
            DropDownFormWidget(
              defaultGender: "Male",
              onChanged: (value) {
                selectedGender = value;
              },
            ),
            UIHelper.verticalSpace(90.0),
            MainButton(
              text: loc.profileProfileInfoUpdateBtnSave,
              onPressed: () {
                print(selectedGender);
              },
            ),
          ],
        ),
      ),
    );
  }

  void initializeData() {
    _nameController.text = widget.payload.userName;
    _emailController.text = widget.payload.userEmail;
    _phoneController.text = widget.payload.phone;
    selectedGender = widget.payload.gender;
  }

  _onCameraClick() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera
      imageQuality: 20,
    );
  }

  _onGalleryClick() async {
    Navigator.of(context).pop();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );

    if (image != null) {
      File? croppedFile = await ImageCropper().cropImage(
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio3x2,
          ],
          cropStyle: CropStyle.circle,
          sourcePath: image.path,
          // androidUiSettings: AndroidUiSettings(
          //     hideBottomControls: true,
          //     showCropGrid: false,
          //     cropFrameColor: Theme.of(context).colorScheme.background,
          //     toolbarTitle: 'Crop your Image',
          //     toolbarColor: MyColors.primary,
          //     toolbarWidgetColor: Colors.white,
          //     initAspectRatio: CropAspectRatioPreset.original,
          //     lockAspectRatio: false),
          // iosUiSettings: const IOSUiSettings(
          //   title: 'Crop your Image',
          // )
          ).then((val) {
        if (val != null) {
          file = val;
          setState(() {});
        }
      });
    }
  }
}
