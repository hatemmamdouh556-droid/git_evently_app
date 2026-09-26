import 'package:evently_project/Ui/details_&_edite/details_screen.dart';
import 'package:evently_project/Ui/screens/home/tabs/widgets/event_item.dart';
import 'package:evently_project/Ui/screens/home/tabs/widgets/tab_item.dart';
import 'package:evently_project/firebase_utils.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/providers/app_language_provider.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/providers/user_provider.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/main_error_widget.dart';
import 'package:evently_project/utils/main_loading_widget.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Event event;
  int selectedIndex = 0;
  List<Event> eventList = [];
  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventStream = FirebaseUtils.getAllEvents();
  }

  void updateStream(int index) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      eventStream = FirebaseUtils.getAllEvents();
    } else {
      eventStream = FirebaseUtils.getFilterEvents(selectedIndex: selectedIndex);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: DefaultTabController(
          length: eventNameList.length,
          child: Column(
            spacing: height * 0.02,
            children: [
              Row(
                spacing: width * 0.02,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_Back,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        userProvider.currentUser!.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    themeProvider.isDark
                        ? Icons.dark_mode_outlined
                        : Icons.wb_sunny_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.006,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      languageProvider.appLanguage.toUpperCase(),
                      style: AppStyles.semi14White,
                    ),
                  ),
                ],
              ),
              TabBar(
                isScrollable: true,
                onTap: (index) {
                  updateStream(index);
                },
                dividerColor: AppColors.transparent,
                indicatorColor: AppColors.transparent,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                tabAlignment: TabAlignment.start,
                tabs: eventNameList.map((eventName) {
                  return TabItem(
                    isSelected:
                        selectedIndex == eventNameList.indexOf(eventName),
                    eventName: eventName,
                  );
                }).toList(),
              ),
              Expanded(
                child: StreamBuilder<List<Event>>(
                  stream: eventStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //todo loading
                      return MainLoadingWidget();
                    } else if (snapshot.hasError) {
                      return MainErrorWidget(
                        errorMessage: snapshot.error.toString(),
                      );
                    } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                      return MainErrorWidget(
                        errorMessage: AppLocalizations.of(context)!
                            .no_event_found,
                      );
                    } else {
                      eventList = snapshot.data!;
                      return eventList.isEmpty
                          ? MainErrorWidget(
                              errorMessage: AppLocalizations.of(context)!
                                  .no_event_found,
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(eventId : eventList[index].id),
                                      ),
                                    );
                                  },
                                  child: EventItem(event: eventList[index]),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: height * 0.02);
                              },
                              itemCount: eventList.length,
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
   eventList.isEmpty?
  Center(child: Text(AppLocalizations.of(context)!.no_event_found,
  style:Theme.of(context).textTheme.headlineMedium ,),)
      :
  ListView.separated(
  itemBuilder: (context, index) {
  return EventItem(event: eventList[index],) ;
  },
  separatorBuilder: (context, index){
  return SizedBox(height: height*0.02,);
  },
  itemCount: eventList.length)


   *\
    */
}
