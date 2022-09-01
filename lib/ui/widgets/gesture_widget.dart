import 'package:flutter/material.dart';

class GestureWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const GestureWidget({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
