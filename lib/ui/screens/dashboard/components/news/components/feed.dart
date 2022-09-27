import 'package:leagx/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:leagx/models/dashboard/news.dart';
import 'package:leagx/ui/widgets/placeholder_tile.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/news_tile.dart';

class Feed extends StatelessWidget {
  Feed({Key? key}) : super(key: key);

  List<News> listOfNews = [];

  @override
  Widget build(BuildContext context) {

    //TODO localization
    listOfNews = context.watch<DashBoardViewModel>().getNews;
    return SizedBox(
      //height: double.infinity,
      child: listOfNews.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: listOfNews.length,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            News news = listOfNews[index];
            return NewsTile(
              imageUrl: news.user.profileImg,
              postedBy: news.user.firstName! + news.user.lastName!,
              when: news.createdAt,
              desc: news.description
            );
          }) : const Center(child: Padding(
            padding: EdgeInsets.symmetric(horizontal :8.0),
            child: PlaceHolderTile(height: 80, msgText: 'No news to show today. Make sure to subscribe at least one league'),
          )),
    );
  }
}
