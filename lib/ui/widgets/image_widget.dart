import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/colors.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;
  final String? imageAsset;
  final File? fileAsset;
  final String placeholder;
  final BoxFit? boxFit;
  final bool shouldClip;
  const ImageWidget(
      {Key? key,
      this.height = 48.0,
      this.width = 48.0,
      this.imageUrl,
      this.imageAsset,
      required this.placeholder,
      this.fileAsset,
      this.boxFit = BoxFit.fill,
      this.shouldClip = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fileAsset != null
        ? Image.file(fileAsset!, fit: boxFit)
        : imageUrl != null
            ? CachedNetworkImage(
                width: width,
                height: height,
                imageUrl: imageUrl!,
                fit: boxFit,
                imageBuilder: (context, imageProvider) => ClipOval(
                  clipper: shouldClip == true ? CustomClipperImage() : null,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider, fit: boxFit),
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) =>
                    Image.asset(placeholder, fit: boxFit),
                placeholder: (_, __) => CircleAvatar(
                  radius: height,
                  backgroundColor: AppColors.textFieldColor,
                ),
              )
            : imageAsset != null
                ? Image.asset(imageAsset!, fit: boxFit)
                : Image.asset(placeholder, fit: boxFit);
  }
}

class CustomClipperImage extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(
        const Offset(1, 1), Offset(size.width - 1, size.height - 1));
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
