import 'package:leagx/constants/assets.dart';

class ImageUtitlity {
  // static String getPlachoder({required ImageTpye type}) {
  //   switch(type) {
  //     case ImageTpye.profileMale:
  //       return '';
  //     case ImageTpye.profileFemale:
  //       return '';
  //     case ImageTpye.leaderMale:
  //       return '';
  //     case ImageTpye.leaderFemale:
  //       return '';
  //     case ImageTpye.expertMale:
  //       return '';
  //     case ImageTpye.expertFemale:
  //       return '';
  //     case ImageTpye.player1:
  //       return '';
  //     case ImageTpye.awayPlayer:
  //       return '';
  //     case ImageTpye.homePlayer:
  //      return '';
  //     case ImageTpye.awayTeam:
  //       return '';
  //     case ImageTpye.homeTeam:
  //       return '';
  //     case ImageTpye.league:
  //       return '';
  //   }
  // }
  static String getRandomProfileAvatar() {
    List<String> listOfAvatars = [
      Assets.icMaleProfile,
      Assets.icLeaderMale,
      Assets.icExpertMale
    ];
    //final _random = Random();
    //String image = listOfAvatars[_random.nextInt(listOfAvatars.length)];
    String image = listOfAvatars[0];
    return image;
  }
}
