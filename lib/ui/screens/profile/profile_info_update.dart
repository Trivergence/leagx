import 'dart:async';
import 'dart:io';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leagx/constants/colors.dart';
import 'package:leagx/models/update_profile_args.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/util/ui/ui_helper.dart';
import 'package:leagx/ui/util/ui/validation_helper.dart';
import 'package:leagx/ui/util/utility/image_utitlity.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:leagx/ui/widgets/dropdown_form_widget.dart';
import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:leagx/ui/widgets/image_widget.dart';
import 'package:leagx/ui/widgets/main_button.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/edit_profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../util/ui/keyboardoverlay.dart';


class ProfileInfoUpdateScreen extends StatefulWidget {
  final UpdateProfileArgs payload;

  ProfileInfoUpdateScreen({Key? key, required this.payload}) : super(key: key);

  @override
  State<ProfileInfoUpdateScreen> createState() => _ProfileInfoUpdateScreenState();
}

class _ProfileInfoUpdateScreenState extends State<ProfileInfoUpdateScreen> {
  late StreamSubscription<bool> keyboardSubscription;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  String? selectedGender;

  final ImagePicker _picker = ImagePicker();
  late EditProfileViewModel profileModel;
  CroppedFile? file;

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    startNodeListener(keyboardVisibilityController);
    
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileModel = context.watch<EditProfileViewModel>();
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
                  onCameraClick: () => _pickImage(ImageSource.camera),
                  onGalleryClick: () => _pickImage(ImageSource.gallery)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: ImageWidget(
                        imageUrl: widget.payload.imgUrl.isNotEmpty ? widget.payload.imgUrl : null,
                        fileAsset: file != null ? File(file!.path) : null,
                        placeholder: ImageUtitlity.getRandomProfileAvatar()
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 1.0,
                  right: 1.0,
                  child: Icon(Icons.camera_alt, size: 30, color: AppColors.colorWhite,),
                )
              ],
            ),
            UIHelper.verticalSpace(50.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                TextFieldWidget(
                  textController: _nameController,
                  hint: 'John Smith',
                  prefix:
                      const IconWidget(iconData: Icons.account_circle_outlined),
                  inputAction: TextInputAction.next,
                  validator: (value) => ValidationHelper.validateField(value),
                ),
                UIHelper.verticalSpace(15.0),
                TextFieldWidget(
                  textController: _emailController,
                  prefix: const IconWidget(iconData: Icons.drafts_outlined),
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  readOnly: true,
                ),
                UIHelper.verticalSpace(15.0),
                TextFieldWidget(
                  textController: _phoneController,
                  focusNode: _passwordNode,
                  hint: '1234567890',
                  prefix: const IconWidget(iconData: Icons.smartphone),
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  validator: (value) => ValidationHelper.validatePhone(value),
                ),
                UIHelper.verticalSpace(15.0),
                DropDownFormWidget(
                  defaultGender: widget.payload.gender.isEmpty
                      ? null
                      : widget.payload.gender,
                  onChanged: (value) {
                    selectedGender = value;
                  },
                  validator: (value) => ValidationHelper.validateField(value)
                )
              ],)
            
            ),
            UIHelper.verticalSpace(90.0),
            MainButton(
              text: loc.profileProfileInfoUpdateBtnSave,
              onPressed: _updateProfile,
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    if (Platform.isIOS) {
      keyboardSubscription.cancel();
      _passwordNode.dispose();
    } 
    super.dispose();
  }

  void initializeData() {
    _nameController.text = widget.payload.userName;
    _emailController.text = widget.payload.userEmail;
    _phoneController.text = widget.payload.phone;
    selectedGender = widget.payload.gender.isEmpty ? null : widget.payload.gender;
  }

  _pickImage(ImageSource pickerType) async {
    Navigator.of(context).pop();
    XFile? image = await _picker.pickImage(
      source: pickerType,
    );

    if (image != null) {
      CroppedFile? croppedFile = await profileModel.compressImage(image);
      if(croppedFile != null) {
        setState(() {
          file = croppedFile;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
      
    if (_formKey.currentState!.validate()) {
      if(file != null) {
        await profileModel.updateProfile(
          context: context,
          imgFile: File(file!.path),
          userName: _nameController.text,
          userEmail: _emailController.text,
          userPhone: _phoneController.text,
          userGender: selectedGender!);
      } else {
        await profileModel.updateProfileWoImage(
          context: context,
          userName: _nameController.text,
          userEmail: _emailController.text,
          userPhone: _phoneController.text,
          userGender: selectedGender!);
      }
      
    }
  }

  void startkeyboardListener(KeyboardVisibilityController keyboardVisibilityController) {
    if (Platform.isIOS) {
      keyboardSubscription = keyboardVisibilityController.onChange.listen(
        (visible) {
          if (visible) {
            KeyboardOverlay.showOverlay(context);
          } else {
            KeyboardOverlay.removeOverlay();
          }
        },
      );
    }
  }

  void startNodeListener(
      KeyboardVisibilityController keyboardVisibilityController) {
    _passwordNode.addListener(
      () {
        if (_passwordNode.hasFocus) {
          startkeyboardListener(keyboardVisibilityController);
        } else {
          if (Platform.isIOS) {
            keyboardSubscription.cancel();
            KeyboardOverlay.removeOverlay();
          }
        }
      },
    );
  }
}
