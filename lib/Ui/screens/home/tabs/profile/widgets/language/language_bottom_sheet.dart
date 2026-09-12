import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_language_provider.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
              //todo change language to english
              languageProvider.changeLanguage('en');
            },
            child:languageProvider.appLanguage=='en'?
            _getSelectedItemLanguage(language:AppLocalizations.of(context)!.english):
                _getUnSelectedItemLanguage(language: AppLocalizations.of(context)!.english)
            ,
          ),
          InkWell(
            onTap: (){
              //todo change language to arabic
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage=='ar'?
                _getSelectedItemLanguage(language: AppLocalizations.of(context)!.arabic)
                :_getUnSelectedItemLanguage(language: AppLocalizations.of(context)!.arabic)
            ,
          ),
        ],

      ),
    );
  }

  Widget _getSelectedItemLanguage({required String language}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,
          style: Theme.of(context).textTheme.titleLarge,),
        Icon(Icons.check,color: AppColors.mainLightColor,size: 30,)
      ],
    );
  }

  Widget _getUnSelectedItemLanguage({required String language}){
    return
      Text(language,
        style: Theme.of(context).textTheme.headlineMedium,);
  }
}
