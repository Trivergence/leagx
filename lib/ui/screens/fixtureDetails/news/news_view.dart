import 'package:leagx/ui/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../models/dashboard/news.dart';

class NewsView extends StatelessWidget {
  final String leagueId;
  NewsView({Key? key, required this.leagueId}) : super(key: key);
  List<News> leagueNews = [];
  @override
  Widget build(BuildContext context) {
    leagueNews = context.read<DashBoardViewModel>().getNewsbyLeague(leagueId);
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: leagueNews.length,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (_, index) {
            News newsItem = leagueNews[index];
            return NewsTile(
              imageUrl: newsItem.user.profileImg,
              postedBy: newsItem.user.firstName! + newsItem.user.lastName!,
              when: newsItem.createdAt,
              desc: newsItem.description,
            );
          }),
    );
  }
}
