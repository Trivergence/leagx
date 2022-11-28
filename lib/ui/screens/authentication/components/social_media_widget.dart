import 'package:leagx/ui/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  const SocialMediaWidget({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.0,
        width: 44.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF0085FF),
              Color(0xFF00417C),
            ],
          ),
        ),
        child: IconWidget(
          iconData: iconData,
          // color: Colors.white,
        ),
      ),
    );
  }
}
