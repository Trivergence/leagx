enum UserType { user, expert, admin }

enum AuthType { apple, twitter, local }

enum DialogType { payout, addCoins }

enum PaymentType { wallet, card }

enum WithdrawType { minimum, maximum, custom }

enum RequestType { clientSideApi, selfHostedApi, footballApi }

enum ScrollDirection { forward, backward }

enum MatchStatus {
  finished("Finished"),
  afterExTime("After ET"),
  cancelled("Cancelled"),
  awarded("Awarded"),
  postponed("Postponed"),
  delayed("Delayed"),
  halfTime("Half Time"),
  empty(""),
  afterPanalty("After Pen.");

  final String value;
  const MatchStatus(this.value);
}
// enum ImageTpye { 
//  profileMale,
//  profileFemale, 
//  leaderMale, 
//  leaderFemale, 
//  expertMale, 
//  expertFemale, 
//  player1,
//  awayPlayer, 
//  homePlayer, 
//  awayTeam, 
//  homeTeam, 
//  league 
//  }