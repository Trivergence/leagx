import 'dart:async';
import 'dart:io';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:country_picker/country_picker.dart';
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
import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:leagx/ui/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/edit_profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../core/network/internet_info.dart';
import '../../util/ui/keyboardoverlay.dart';

class ProfileInfoUpdateScreen extends StatefulWidget {
  final UpdateProfileArgs payload;

  const ProfileInfoUpdateScreen({Key? key, required this.payload})
      : super(key: key);

  @override
  State<ProfileInfoUpdateScreen> createState() =>
      _ProfileInfoUpdateScreenState();
}

class _ProfileInfoUpdateScreenState extends State<ProfileInfoUpdateScreen> {
  late StreamSubscription<bool> keyboardSubscription;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  String? selectedGender;
  String? dialCode;
  // Country selectedCountry = const Country(
  //   name: "Saudi Arabia",
  //   flag: "🇸🇦",
  //   code: "SA",
  //   dialCode: "966",
  //   minLength: 9,
  //   maxLength: 9,
  // );

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
                  onTap: () => profileModel.pickImage(
                      context: context,
                      onCameraClick: () => _pickImage(ImageSource.camera),
                      onGalleryClick: () => _pickImage(ImageSource.gallery)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: ImageWidget(
                          imageUrl: widget.payload.imgUrl.isNotEmpty
                              ? widget.payload.imgUrl
                              : null,
                          fileAsset: file != null ? File(file!.path) : null,
                          placeholder: ImageUtitlity.getRandomProfileAvatar()),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 1.0,
                  right: 1.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: AppColors.colorWhite,
                  ),
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
                      counterText: " ",
                      prefix: const IconWidget(
                          iconData: Icons.account_circle_outlined),
                      inputAction: TextInputAction.next,
                      validator: (value) =>
                          ValidationHelper.validateField(value),
                    ),
                    UIHelper.verticalSpace(15.0),
                    TextFieldWidget(
                      textController: _emailController,
                      prefix: const IconWidget(iconData: Icons.drafts_outlined),
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      readOnly: true,
                      counterText: " ",
                    ),
                    UIHelper.verticalSpace(15.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _showPicker,
                          child: Container(
                            height: 57,
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                                color: AppColors.textFieldColor,
                                border: Border.all(color: AppColors.colorBlack),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text:
                                      dialCode ?? AppConstants.defaultDialCode,
                                  textSize: 14,
                                ),
                                const Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall,
                        Expanded(
                          child: TextFieldWidget(
                            counterText: " ",
                            textController: _phoneController,
                            focusNode: _passwordNode,
                            hint: '(000) 000000',
                            prefix:
                                const IconWidget(iconData: Icons.smartphone),
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.number,
                            validator: (value) =>
                                ValidationHelper.validatePhone(value),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(15.0),
                    DropDownFormWidget(
                      defaultGender: widget.payload.gender.isEmpty
                          ? null
                          : widget.payload.gender,
                      onChanged: (value) {
                        selectedGender = value;
                      },
                    )
                  ],
                )),
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
    setCountryCredentials(widget.payload.phone);
    //_phoneController.text = setCountry;
    selectedGender =
        widget.payload.gender.isEmpty ? null : widget.payload.gender;
  }

  _pickImage(ImageSource pickerType) async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      Navigator.of(context).pop();
      XFile? image = await _picker.pickImage(
        source: pickerType,
      );
      if (image != null) {
        CroppedFile? croppedFile = await profileModel.compressImage(image);
        if (croppedFile != null) {
          setState(() {
            file = croppedFile;
          });
        }
      }
    }
  }

  Future<void> _updateProfile() async {
    bool isConnected = await InternetInfo.isConnected();
    if (isConnected == true) {
      if (_formKey.currentState!.validate()) {
        if (file != null) {
          await profileModel.updateProfile(
              context: context,
              imgFile: File(file!.path),
              userName: _nameController.text,
              userEmail: _emailController.text,
              userPhone: _phoneController.text.isNotEmpty
                  ? ((dialCode ?? AppConstants.defaultDialCode) +
                      "-" +
                      _phoneController.text)
                  : "",
              userGender: selectedGender!);
        } else {
          await profileModel.updateProfileWoImage(
              context: context,
              userName: _nameController.text,
              userEmail: _emailController.text,
              userPhone: _phoneController.text.isNotEmpty
                  ? ((dialCode ?? AppConstants.defaultDialCode) +
                      "-" +
                      _phoneController.text)
                  : "",
              userGender: selectedGender ?? "");
        }
      }
    }
  }

  void startkeyboardListener(
      KeyboardVisibilityController keyboardVisibilityController) {
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

  void setCountryCredentials(String phone) {
    if (phone.isEmpty) {
      _phoneController.text = phone;
    } else {
      if (phone.contains("-")) {
        List<String> phoneArr = phone.split("-");
        List<Country> _countries = CountryService()
            .getAll()
            .where((countryItem) =>
                countryItem.phoneCode == phoneArr[0].replaceAll("+", ""))
            .toList();

        if (_countries.isNotEmpty) {
          Country country = _countries[0];
          //selectedCountry = country;
          dialCode = country.phoneCode;
        } else {}
        _phoneController.text = phoneArr[1];
      } else {
        _phoneController.text = phone;
      }
    }
  }

  void _showPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        searchTextStyle: const TextStyle(color: AppColors.colorWhite),
        flagSize: 25,
        backgroundColor: AppColors.colorBackground,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          hintText: loc.profileProfileInfoUpdatePickerSearch,
          hintStyle: TextStyle(color: AppColors.colorWhite.withOpacity(0.3)),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.colorWhite,
          ),
          fillColor: AppColors.textFieldColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          //enabledBorder:
        ),
      ),
      onSelect: (Country country) {
        dialCode = country.phoneCode;
        setState(() {});
      },
    );
  }
}
