import 'package:evently_project/Ui/auth/login/login_screen.dart';
import 'package:evently_project/Ui/auth/register/register_screen.dart';
import 'package:evently_project/Ui/screens/home/home_screen.dart';
import 'package:evently_project/Ui/screens/home/tabs/profile/widgets/app_theme.dart';
import 'package:evently_project/Ui/screens/intro_screen/intro_screen.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_language_provider.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/app_routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>AppLanguageProvider() ,),
        ChangeNotifierProvider(create: (context) => AppThemeProvider(),)
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider =Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.introRouteNamed,
      routes: {
        AppRoutes.introRouteNamed : (context) => IntroScreen(),
        AppRoutes.homeRouteNamed : (context) => HomeScreen(),
        AppRoutes.loginRouteNamed : (context) => LoginScreen(),
        AppRoutes.registerRouteNamed : (context) => RegisterScreen(),

      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales ,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme ,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }

}