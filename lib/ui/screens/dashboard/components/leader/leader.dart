import 'package:leagx/constants/strings.dart';
import 'package:leagx/ui/screens/dashboard/components/leader/components/leader_board_tile.dart';
import 'package:flutter/material.dart';
import 'components/expanded_leader_tile.dart';

class LeaderScreen extends StatelessWidget {
  const LeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return index != 0
              ? LeaderBoardTile(
                  number: index,
                  imageUrl: Strings().placeHolderUrl,
                  title: "David J.P",
                  numberOfPrediciton: 20,
                  successRate: '90.5')
              : ExpandedLeaderTile(
                  imageUrl: Strings().placeHolderUrl,
                  title: "Martin Braithwaite",
                  numberOfPrediciton: 20,
                  successRate: '99.9',
                );
        });
  }
}
