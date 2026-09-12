import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height * 0.25 ,
      padding: EdgeInsets.symmetric(
        horizontal: width*0.02,
        vertical: height*0.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Theme
            .of(context)
            .dividerColor),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            themeProvider.isDark
                ? AppAssets.birthdayDark
                : AppAssets.birthdayLight,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: width*0.02,
            vertical: height*0.005
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2, color: Theme.of(context).dividerColor),),
        child: Text("21 Jen",
        style: Theme.of(context).textTheme.bodyMedium,),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: width*0.02,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2, color: Theme.of(context).dividerColor),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text("This is a Birthday Party ",
              style: Theme.of(context).textTheme.bodySmall,),
            ),
            IconButton(onPressed: (){
              //todo : add to favorite
            }, icon: Icon(Icons.favorite_outline,size: 25 ,color: Theme.of(context).cardColor,))
          ],
        ),
      ),
    ]
    )
    ,
    );
  }
}
