import 'package:leagx/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:leagx/models/dashboard/news.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/news_tile.dart';

class Feed extends StatelessWidget {
  Feed({Key? key}) : super(key: key);

  List<News> listOfNews = [];

  @override
  Widget build(BuildContext context) {
    listOfNews = context.watch<DashBoardViewModel>().getNews;
    return SizedBox(
      height: double.infinity,
      child: ListView.builder(
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
          }),
    );
  }
}
