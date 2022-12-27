// ignore_for_file: prefer_const_constructors

import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:leagx/ui/widgets/placeholder_tile.dart';
import 'package:leagx/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../models/dashboard/news.dart';

// ignore: must_be_immutable
class NewsView extends StatelessWidget {
  final String leagueId;
  NewsView({Key? key, required this.leagueId}) : super(key: key);
  List<News> leagueNews = [];
  @override
  Widget build(BuildContext context) {
    leagueNews = context.read<DashBoardViewModel>().getNewsbyLeague(leagueId);
    return leagueNews.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: leagueNews.length,
                padding: const EdgeInsets.only(top: 20),
                itemBuilder: (_, index) {
                  News newsItem = leagueNews[index];
                  return NewsTile(
                    imageUrl: newsItem.user.profileImg,
                    postedBy: newsItem.user.firstName!,
                    when: newsItem.createdAt,
                    desc: newsItem.description,
                  );
                }),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 200),
            child: PlaceHolderTile(
                height: 50, msgText: loc.fixtureDetailsNewsTxtEmptyList),
          );
  }
}
