class Strings {
  //General
  static const String appName = "LeagX";

  //app language
  static const String english = 'en';
  static const String arabic = 'ar';

  String placeHolderUrl =
      "https://picsum.photos/100/100?${DateTime.now().microsecondsSinceEpoch}";

  // exception and error messages
  static const String noInternet = "No Internet";
  static const String badHappened =
      "Somethig bad happened occured, please try again later";

  //keys
  static const String apiKeyTwitter = "i3ZQyWHc6vD7yyUZuYiookqAK";
  static const String apiSecretKeyTwitter =
      "a7B3JE1V3zV3m0yhLPRjQnhtwEsN5d7rpElpHFIri7Gmf1nCUD";

  //uri
  static const String redirectUriTwitter = "leagx://";
}
