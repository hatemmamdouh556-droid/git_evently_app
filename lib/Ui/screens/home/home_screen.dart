import 'package:evently_project/Ui/screens/home/tabs/favorite/favorite_tab.dart';
import 'package:evently_project/Ui/screens/home/tabs/home/home_tab.dart';
import 'package:evently_project/Ui/screens/home/tabs/profile/profile_tab.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0 ;
  List <Widget> tabList = [
    HomeTab(),FavoriteTab(),ProfileTab()
  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex ,
          onTap: (index){
          selectIndex = index;
          setState(() {

          });
          },
          items:[
            _buildBottomNavigationBarItem(
              isSelected: selectIndex == 0 ,
                unSelectedIconName: Icons.home_outlined ,
                selectedIconName: Icons.home_rounded,
                label: AppLocalizations.of(context)!.home),

            _buildBottomNavigationBarItem(
              isSelected: selectIndex == 1 ,
                unSelectedIconName: Icons.favorite_outline_outlined ,
                selectedIconName: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite),

            _buildBottomNavigationBarItem(
              isSelected: selectIndex == 2 ,
                unSelectedIconName: Icons.person_2_outlined ,
                selectedIconName: Icons.person,
                label: AppLocalizations.of(context)!.profile ),
            // _buildBottomNavigationBarItem(
            //     selectedIconName: Icons.favorite_outline_outlined , label:AppLocalizations.of(context)!.favorite),
            // _buildBottomNavigationBarItem(
            //     selectedIconName: Icons.person_2_outlined , label:AppLocalizations.of(context)!.profile),
          ]
      ),
      body: tabList[selectIndex],

      floatingActionButton: FloatingActionButton(onPressed: (){
        //todo : navigate to add event screen
        Navigator.of(context).pushNamed(AppRoutes.addEventRouteNamed);
      },
        child: Icon(Icons.add,color: AppColors.whiteColor,size: 25,),
      ),
    ) ;
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData selectedIconName,
    required IconData unSelectedIconName,
    required String label,
    required isSelected
}){
    return BottomNavigationBarItem(
        icon: Icon(isSelected ? selectedIconName : unSelectedIconName),
        label: label);
}
}