import 'package:bailbooks_defendant/constants/strings.dart';
import 'package:bailbooks_defendant/ui/screens/admin_fixture_detail/components/predictions/components/predictions_tile.dart';
import 'package:flutter/material.dart';

class FixtureDetailPredictionScreen extends StatelessWidget {
  const FixtureDetailPredictionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
        itemBuilder: (context, index) {
          return PredictionsTile(
            imageUrl: Strings().placeHolderUrl,
            title: 'Smith Little',
            teamOneDetails: 'ufc - 3',
            teamTwoDetails: 'ars - 5',
          );
        },
      ),
    );
  }
}
