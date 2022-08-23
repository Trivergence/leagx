import 'package:bailbooks_defendant/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/news_tile.dart';

class MyFeed extends StatelessWidget {
  const MyFeed({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      padding: const EdgeInsets.only(top: 20),
      itemBuilder: (_, index) {
      return  NewsTile(
        imageUrl: Strings.placeHolderUrl,
        postedBy: 'James FC',
        when: '1 min ago',
        desc: 'FIFA’s iconic competitions inspire billions of football fans and provide opportunities to have a wider positive social and environmental impact. By the global nature of the tournaments it ...',
      );
      }),
    );
  }
}