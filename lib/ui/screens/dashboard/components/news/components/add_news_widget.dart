import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';

class AddNewsWidget extends StatelessWidget {
  const AddNewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
       bottom: 40,
       right: 15,
       child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: AppColors.orangishGradient,
          shape: BoxShape.circle
        ),
        child: const Icon(Icons.add),
        ),
     );
  }
}