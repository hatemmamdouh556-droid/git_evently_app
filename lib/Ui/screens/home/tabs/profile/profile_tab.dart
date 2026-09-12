import 'package:evently_project/Ui/screens/home/tabs/profile/widgets/app_config_item.dart';
import 'package:evently_project/Ui/screens/home/tabs/profile/widgets/language/language_bottom_sheet.dart';
import 'package:evently_project/Ui/screens/home/tabs/profile/widgets/theme/theme_bottom_sheet.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_language_provider.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: width*0.02,
        vertical: height*0.04
      ),
      child: SafeArea(
        child: Column(
          spacing: height*0.02,
          children: [
            SizedBox(height: height*0.02,),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.logoRouteImage),
            ),
            Text("Route Academy",
            style: Theme.of(context).textTheme.headlineLarge,),
            Text("routeacademy@gmail.com",
            style: Theme.of(context).textTheme.bodyLarge,),
            SizedBox(height: height*0.01,),
            AppConfigItem(text:AppLocalizations.of(context)!.dark_mode,
              icon  : Switch(
                activeTrackColor: AppColors.mainDarkColor,
                  inactiveTrackColor: AppColors.lightGreyColor,
                  activeThumbColor: AppColors.whiteColor,
                  inactiveThumbColor: AppColors.whiteColor,
                  trackOutlineColor:WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                    return AppColors.transparent; // Use the default color.
                  }),
                  value: themeProvider.isDark,
                  onChanged: (value){
                    themeProvider.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                  }),
            ),
            AppConfigItem(text:AppLocalizations.of(context)!.language, icon:IconButton(
                onPressed:(){
                  //todo :show language bottom sheet
                  showLanguageBottomSheet();
                } ,
                icon: Icon(Icons.arrow_forward_ios_outlined ,
                  color:Theme.of(context).cardColor ,)),),
            AppConfigItem(
              text:AppLocalizations.of(context)!.logout,
              icon:IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.logout,color: AppColors.redColor)
                ,),)

          ],
        
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet(),
    ) ;
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeBottomSheet(),);
  }
}
