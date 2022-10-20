import 'package:flutter/material.dart';

import 'text_widget.dart';

class ScoreChip extends StatelessWidget {
  final String firstScore;
  final String secondScore;
  final bool hasGradient;
  const ScoreChip({
    Key? key,
    required this.firstScore,
    required this.secondScore, this.hasGradient = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 80,
      decoration: hasGradient ? const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gradient: LinearGradient(colors: [
            Color(0xFF2A3041),
            Color(0xFF2B344D),
            Color(0xFF2A3041),
          ])) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextWidget(
            text: firstScore.isEmpty ? "0" : firstScore,
            fontWeight: FontWeight.w600,
          ),
          const TextWidget(
            text: "-",
            fontWeight: FontWeight.w600,
          ),
          TextWidget(
            text: secondScore.isEmpty ? "0" : secondScore,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
