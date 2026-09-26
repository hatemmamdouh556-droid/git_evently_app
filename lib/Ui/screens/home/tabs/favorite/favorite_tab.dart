import 'package:evently_project/Ui/screens/home/tabs/widgets/event_item.dart';
import 'package:evently_project/Ui/widgets/custom_text_field.dart';
import 'package:evently_project/firebase_utils.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/utils/main_error_widget.dart';
import 'package:evently_project/utils/main_loading_widget.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? favoriteStream;

  List<Event> favoriteEventList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteStream = FirebaseUtils.getAllFavoriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          spacing: height * 0.02,
          children: [
            CustomTextField(
              borderColor: Theme.of(context).dividerColor,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              style: Theme.of(context).textTheme.bodySmall,
              suffixIcon: Icon(
                Icons.search,
                size: 25,
                color: Theme.of(context).cardColor,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: favoriteStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    //todo : loading
                    return MainLoadingWidget();
                  } else if (snapshot.hasError) {
                    //todo :Error
                    return MainErrorWidget(errorMessage: snapshot.error.toString());
                  } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                    return  MainErrorWidget(errorMessage: AppLocalizations.of(context)!.no_favorite_event_found);
                  } else
                    favoriteEventList = snapshot.data!;
                  return favoriteEventList.isEmpty
                      ? MainErrorWidget(errorMessage: AppLocalizations.of(context)!.no_favorite_event_found)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return EventItem(event: favoriteEventList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: height * 0.02);
                          },
                          itemCount: favoriteEventList.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
