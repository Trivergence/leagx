import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';

class AddNewsWidget extends StatelessWidget {
  final VoidCallback onAddPressed;
  const AddNewsWidget({
    Key? key,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 15,
      child: InkWell(
        onTap: onAddPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: AppColors.colorYellow, shape: BoxShape.circle),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
