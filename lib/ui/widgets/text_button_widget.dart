import 'package:leagx/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TextButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: TextWidget(
        text: text,
      ),
      onPressed: onPressed,
    );
  }
}
