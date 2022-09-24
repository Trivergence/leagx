import 'package:leagx/constants/strings.dart';
import 'package:leagx/ui/widgets/news_tile.dart';
import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (_, index) {
            return NewsTile(
              imageUrl: Strings().placeHolderUrl,
              postedBy: 'James FC',
              when: DateTime(2022),
              desc:
                  'FIFA’s iconic competitions inspire billions of football fans and provide opportunities to have a wider positive social and environmental impact. By the global nature of the tournaments it ...',
            );
          }),
    );
  }
}
