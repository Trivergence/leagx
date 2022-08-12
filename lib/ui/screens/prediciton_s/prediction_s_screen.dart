import 'package:bailbooks_defendant/constants/assets.dart';
import 'package:bailbooks_defendant/constants/colors.dart';
import 'package:bailbooks_defendant/constants/dimens.dart';
import 'package:bailbooks_defendant/ui/screens/prediciton_s/components/prediction_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:bailbooks_defendant/ui/screens/dashboard/components/fixture_widget.dart';
import 'package:bailbooks_defendant/ui/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class PredicitonsScreen extends StatelessWidget {
  const PredicitonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBarWidget(
        title: 'Predictions',
        isDrawer: true,
        trailing: IconButton(
          icon: const IconWidget(
            iconData: Icons.notifications_outlined,
          ),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontalPadding,
            vertical: Dimens.verticalPadding),
        itemBuilder: (context, index) {
          return const PredictionWidget(
            teamOneFlag: Assets.ufcFlag,
            teamOneName: 'UFC',
            teamOneScore: 3,
            teamTwoFlag: Assets.arsFlag,
            teamTwoName: 'ARS',
            teamTwoScore: 5,
            predictionRate: '95.9%',
            // isPending: true,
          );
        },
      ),
    );
  }
}
