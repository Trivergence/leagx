class ChoosePlanArgs {
  String leagueId;
  String leagueImg;
  String leagueTitle;
  bool isRedeeming;
  bool isUpgrading;
  ChoosePlanArgs(
      {required this.leagueId,
      required this.leagueImg,
      required this.leagueTitle,
      required this.isRedeeming,
      this.isUpgrading = false});
}
