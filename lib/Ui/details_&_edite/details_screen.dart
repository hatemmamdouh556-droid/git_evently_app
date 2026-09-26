import 'package:easy_localization/easy_localization.dart';
import 'package:evently_project/Ui/details_&_edite/edit_screen.dart';
import 'package:evently_project/Ui/details_&_edite/test.dart';
import 'package:evently_project/firebase_utils.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/EventImageHelper.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String eventId;

  const DetailsScreen({super.key, required this.eventId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Event? event;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getEventDetails();
  }

  void getEventDetails() async {
    event = await FirebaseUtils.getEventById(widget.eventId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event details',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).highlightColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themeProvider.isDark
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()async{
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(event: event!),
                ),
              );
              getEventDetails();
            },
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).cardColor),
          ),
          IconButton(
            onPressed: deleteEvent,
            icon: const Icon(Icons.delete_outline, color: AppColors.redColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: height * 0.02,
          children: [
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(EventImageHelper.getImage(context, event!.eventCategoryIndex)),
                ),
              ),
            ),
            Text(
              event!.eventTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).highlightColor,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('dd MMMM').format(event!.eventDate),style: Theme.of(context).textTheme.headlineMedium,),
                      Text(DateFormat('hh:mm a').format(event!.eventDate),style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Description',
              style:Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).highlightColor,
              ),
              child: Text(event!.eventDescription,style: Theme.of(context).textTheme.headlineMedium),
            ),
          ],
        ),
      ),
    );
  }

  void deleteEvent() {
    FirebaseUtils.deleteEvent(event!).then((_) {
      Navigator.pop(context);
    });
  }
}
