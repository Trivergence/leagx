
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/leader/components/leader_board_tile.dart';
import 'package:bailbooks_defendant/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../widgets/gradient_border_widget.dart';
import 'components/expanded_leader_tile.dart';

class LeaderScreen extends StatelessWidget {
  const LeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
      return index != 0 ? LeaderBoardTile(number: index + 1,
        imageUrl: 'https://i.pravatar.cc/300',
        title: "David J.P",
        numberOfPrediciton: 20,
        successRate: '90.5')
        : const ExpandedLeaderTile(
            imageUrl: 'https://i.pravatar.cc/300',
            title: "Martin Braithwaite",
            numberOfPrediciton: 20,
            successRate: '99.9',
        );
    });
  }
}

