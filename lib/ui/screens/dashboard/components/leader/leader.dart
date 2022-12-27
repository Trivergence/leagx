import 'package:leagx/models/leader.dart';
import 'package:leagx/ui/screens/dashboard/components/leader/components/leader_board_tile.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/colors.dart';
import '../../../../util/locale/localization.dart';
import '../../../../widgets/placeholder_tile.dart';
import 'components/expanded_leader_tile.dart';

// ignore: must_be_immutable
class LeaderScreen extends StatelessWidget {
  LeaderScreen({Key? key}) : super(key: key);

  List<Leader> listOfLeader = [];
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    listOfLeader = _context.select<DashBoardViewModel, List<Leader>>(
        (dasboardModel) => dasboardModel.getLeaders);
    return RefreshIndicator(
      backgroundColor: AppColors.textFieldColor,
      onRefresh: _refreshData,
      child: listOfLeader.isNotEmpty
          ? ListView.builder(
              itemCount: listOfLeader.length,
              itemBuilder: (context, index) {
                Leader leader = listOfLeader[index];
                return index != 0
                    ? LeaderBoardTile(
                        number: index + 1,
                        imageUrl: leader.profileImg!,
                        title: leader.firstName!,
                        numberOfPrediciton: leader.totalPredictions,
                        successRate:
                            leader.predictionSuccessRate!.toStringAsFixed(1))
                    : ExpandedLeaderTile(
                        imageUrl: leader.profileImg!,
                        title: leader.firstName!,
                        numberOfPrediciton: leader.totalPredictions,
                        successRate:
                            leader.predictionSuccessRate!.toStringAsFixed(1),
                      );
              })
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PlaceHolderTile(
                    height: 80, msgText: loc.dashboardLeaderMsgEmpty),
              ),
            ),
    );
  }

  Future<void> _refreshData() async {
    DashBoardViewModel dashBoardViewModel = _context.read<DashBoardViewModel>();
    await dashBoardViewModel.getAllLeaders();
    await dashBoardViewModel.notify();
  }
}
