import 'package:bailbooks_defendant/constants/strings.dart';
import 'package:bailbooks_defendant/ui/screens/choose_an_expert/components/choose_an_expert_tile.dart';
import 'package:bailbooks_defendant/ui/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ChooseAnExpertScreen extends StatelessWidget {
  const ChooseAnExpertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Choose an Expert',
      ),
      body: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ChooseAnExpertTile(
            number: index+1,
            imageUrl: Strings().placeHolderUrl,
            title: "David J.P",
            numberOfPrediciton: 20,
            successRate: '90.5',
          );
        },
      ),
    );
  }
}
