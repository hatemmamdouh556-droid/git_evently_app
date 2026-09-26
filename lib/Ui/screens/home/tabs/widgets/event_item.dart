import 'package:easy_localization/easy_localization.dart';
import 'package:evently_project/firebase_utils.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/EventImageHelper.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:evently_project/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Event event;
   EventItem({super.key,required this.event});

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
              EventImageHelper.getImage(context, event.eventCategoryIndex)
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
        child: Text(DateFormat('dd MMM').format(
          event.eventDate
        ).toString(),
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
              child: Text(event.eventTitle,
              style: Theme.of(context).textTheme.bodySmall,),
            ),
            IconButton(onPressed: (){
              //todo : add to favorite
              FirebaseUtils.updateIsFavorite(event).then((value) {
                ToastUtils.toastMsg(
                    msg: 'Event update successfully.',
                    backgroundColor: AppColors.greenColor,
                    textColor: AppColors.whiteColor);

              },)
              .catchError((error){
                ToastUtils.toastMsg(
                    msg: error.toString(),
                    backgroundColor: AppColors.redColor,
                    textColor: AppColors.whiteColor);
              });
            }, icon: Icon(event.isFavorite?
                Icons.favorite
                :
              Icons.favorite_outline,size: 25 ,color: Theme.of(context).cardColor,))
          ],
        ),
      ),
    ]
    )
    ,
    );
  }
}
