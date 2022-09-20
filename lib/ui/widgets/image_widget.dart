import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leagx/constants/assets.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;
  final String? imageAsset;
  final String? placeholder;
  const ImageWidget(
      {Key? key,
      this.height = 48.0,
      this.width = 48.0,
       this.imageUrl,
      this.imageAsset,
      this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl!=null? CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl!,
      fit:BoxFit.fill,
      errorWidget: (_, __,___) => Image.asset(Assets.imgPlaceholder),
      placeholder: (_,__) => Image.asset(Assets.imgPlaceholder),
    ):imageAsset!=null? Image.asset(imageAsset!):const SizedBox();
  }
}
