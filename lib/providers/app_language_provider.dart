import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
   //todo : data - logic
  String appLanguage = "en";

  void changeLanguage(String newLanguage){
    if(appLanguage==newLanguage){
      return;
    }else{
      appLanguage = newLanguage;
      notifyListeners();
    }

  }
}