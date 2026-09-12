import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppThemeProvider extends ChangeNotifier{
   ThemeMode appTheme = ThemeMode.light ;

   void changeTheme (ThemeMode newTheme){
     if(appTheme == newTheme){
       return;
     }
     appTheme = newTheme ;
     notifyListeners();
   }

   bool isDarkMode(){
     return appTheme == ThemeMode.dark ;
   }
   bool get isDark => appTheme ==ThemeMode.dark;
}