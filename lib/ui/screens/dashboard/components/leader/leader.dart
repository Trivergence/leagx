import 'package:leagx/constants/strings.dart';
import 'package:leagx/models/leader.dart';
import 'package:leagx/ui/screens/dashboard/components/leader/components/leader_board_tile.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';
import 'components/expanded_leader_tile.dart';

class LeaderScreen extends StatelessWidget {
  LeaderScreen({Key? key}) : super(key: key);

  List<Leader> listOfLeader = [];
  @override
  Widget build(BuildContext context) {
    listOfLeader = context.read<DashBoardViewModel>().getLeaders;
    return ListView.builder(
        itemCount: listOfLeader.length,
        itemBuilder: (context, index) {
          Leader leader = listOfLeader[index];
          return index != 0
              ? LeaderBoardTile(
                  number: index + 1,
                  imageUrl: leader.profileImg!,
                  title: leader.firstName!,
                  numberOfPrediciton: leader.totalPredictions,
                  successRate: leader.predictionSuccessRate!.toStringAsFixed(1))
              : ExpandedLeaderTile(
                  imageUrl: leader.profileImg!,
                  title: leader.firstName!,
                  numberOfPrediciton: leader.totalPredictions,
                  successRate: leader.predictionSuccessRate!.toStringAsFixed(1),
                );
        });
  }
}
