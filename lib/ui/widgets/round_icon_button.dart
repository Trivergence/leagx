import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.colorPrimary,
      ),
      child: Center(
        child: IconButton(
          padding: const EdgeInsets.all(0.0),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
