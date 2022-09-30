import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/assets.dart';
import 'package:leagx/constants/colors.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;
  final String? imageAsset;
  final File? fileAsset;
  final String placeholder;
  const ImageWidget(
      {Key? key,
      this.height = 48.0,
      this.width = 48.0,
      this.imageUrl,
      this.imageAsset,
      required this.placeholder,
      this.fileAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fileAsset!= null ? Image.file(fileAsset!, fit: BoxFit.fill) : imageUrl != null ? CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl!,
      fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
        ),),
      errorWidget: (_, __,___) => Image.asset(placeholder, fit: BoxFit.fill),
      placeholder: (_,__) => CircleAvatar(radius: height,backgroundColor: AppColors.textFieldColor,),
    ): imageAsset != null ? Image.asset(imageAsset!, fit: BoxFit.fill) : Image.asset(placeholder, fit: BoxFit.fill);
  }
}
