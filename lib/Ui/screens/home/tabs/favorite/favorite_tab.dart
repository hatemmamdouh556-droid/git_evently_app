import 'package:evently_project/Ui/screens/home/tabs/widgets/event_item.dart';
import 'package:evently_project/Ui/widgets/custom_text_field.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return SafeArea(
      child: Padding(
          padding:EdgeInsets.symmetric(
            horizontal: width*0.04,
            vertical: height*0.02
          ),
        child: Column(spacing: height*0.02,
          children: [
            CustomTextField(
              borderColor: Theme.of(context).dividerColor,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              style:Theme.of(context).textTheme.bodySmall,
              suffixIcon: Icon(Icons.search,size: 25,color: Theme.of(context).cardColor,),

            ),
            Expanded(
                child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem() ;
                },
                separatorBuilder: (context, index){
                  return SizedBox(height: height*0.02,);
                },
                itemCount: 20))
          ],
        ),
      ),
    );
  }
}
