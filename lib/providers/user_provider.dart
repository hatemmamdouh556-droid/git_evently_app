

import 'package:evently_project/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  //todo : data
  MyUser? currentUser;
  void  updateUser(MyUser newUser){
    currentUser =newUser;
    notifyListeners();
  }
}