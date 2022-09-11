import 'package:flutter/material.dart';
import 'package:leagx/constants/strings.dart';
import 'package:leagx/providers/localization_provider.dart';
import 'package:leagx/ui/screens/dashboard/components/setting/components/language_tile.dart';
import 'package:leagx/ui/util/locale/localization.dart';
import 'package:leagx/ui/widgets/bar/app_bar_widget.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: loc.settingChooseLanguageTxtChooseLanguage,
      ),
      body: Column(
        children: [
          LanguageTile(
            onTap: () {
              context.read<LocalizationProvider>().changeLanguage(Strings.english);
            },
            text: loc.settingChooseLanguageTxtEnglish,
          ),
          LanguageTile(
            onTap: () {
              context.read<LocalizationProvider>().changeLanguage(Strings.arabic);
            },
            text: loc.settingChooseLanguageTxtArabic,
          ),
        ],
      ),
    );
  }
}
