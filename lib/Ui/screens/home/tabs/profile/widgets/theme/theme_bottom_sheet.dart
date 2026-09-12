import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: width*0.04,
        vertical: height*0.04
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: height*0.04,
        children: [
          InkWell(
            onTap: (){
              //todo change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDark?
            _getSelectedItemTheme(theme: AppLocalizations.of(context)!.dark):
                _getUnSelectedItemTheme(theme:  AppLocalizations.of(context)!.dark),
          ),
          InkWell(
            onTap: (){

              //todo change theme to light
              themeProvider.changeTheme(ThemeMode.light);

            },
            child: !themeProvider.isDark?
                _getUnSelectedItemTheme(theme: AppLocalizations.of(context)!.light):
                _getSelectedItemTheme(theme: AppLocalizations.of(context)!.light),
          ),
        ],

      ),
    );
  }

  Widget _getSelectedItemTheme({required String theme}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme,
          style: AppStyles.bold16Black,),
        Icon(Icons.check,color: AppColors.mainLightColor,size: 30,)
      ],
    );
  }

  Widget _getUnSelectedItemTheme({required String theme}){
    return
      Text(theme,
        style: AppStyles.bold16Black,);
  }
}
