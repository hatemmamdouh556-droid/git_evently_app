
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventImageHelper {
  static const List<String> _darkImages = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  static const List<String> _lightImages = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exhibitionLight,
  ];

  static String getImage(BuildContext context, int categoryIndex) {
    var isDark = Provider.of<AppThemeProvider>(context).isDark;
    return isDark ? _darkImages[categoryIndex - 1] : _lightImages[categoryIndex - 1];
  }
}