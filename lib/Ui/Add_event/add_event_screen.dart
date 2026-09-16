import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_project/Ui/Add_event/Widget/custom_date_time_widget.dart';
import 'package:evently_project/Ui/screens/home/tabs/widgets/event_item.dart';
import 'package:evently_project/Ui/screens/home/tabs/widgets/tab_item.dart';
import 'package:evently_project/Ui/widgets/custom_elevated_botton.dart';
import 'package:evently_project/Ui/widgets/custom_text_field.dart';
import 'package:evently_project/firebase_utils.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:evently_project/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<String> eventImageDark = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  List<String> eventImageLight = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exhibitionLight,
  ];

  List<String> eventNameList = [];

  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime? selectedDate ;
  String formatDate ='' ;
  TimeOfDay? selectedTime;
  String formatTime ='' ;
  String selectedEventName ='' ;
  String selectedEventImage ='' ;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    selectedEventName =eventNameList[selectedIndex];
    selectedEventImage = themeProvider.isDark ?
        eventImageDark[selectedIndex]:
        eventImageLight[selectedIndex];


    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.add_event,
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themeProvider.isDark
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      image: AssetImage(
                        selectedEventImage

                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItem(
                          isSelected: selectedIndex == index,
                          eventName: eventNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventNameList.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.event_title,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  onChange: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter event title';
                    }
                    return null;
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.event_description,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 3,
                  onChange: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter event description';
                    }
                    return null;
                  },
                ),
                CustomDateTimeWidget(
                  icon: Icon(
                    Icons.date_range_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  chooseDateOrTime:selectedDate == null?
                  AppLocalizations.of(context)!.choose_date:
                  formatDate,

                  onPressed: chooseDate,
                ),
                CustomDateTimeWidget(
                  icon: Icon(
                    Icons.timer_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  chooseDateOrTime:selectedTime == null?
                  AppLocalizations.of(context)!.choose_time:
                  formatTime,
                  onPressed: chooseTime,
                ),
                CustomElevatedBotton(
                  onPressed: addEvent,
                  child: Text(
                    AppLocalizations.of(context)!.add_event,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo : add event to firestore
      Event event =Event(
          eventImage: selectedEventName,
          eventName: selectedEventName,
          eventTitle: title,
          eventDescription: description,
          eventDate: DateTime(selectedDate!.year,selectedDate!.month
              ,selectedDate!.day,selectedTime!.hour,selectedTime!.minute)
      );
      //todo :Future => Success => listen => then() online, timeOut () offline
      //todo :Future  => Error  listen => catchError() => onError()

      FirebaseUtils.addEventToFireStore(event).then((value){
        ToastUtils.toastMsg(
        msg: 'Event added successfully.',
        backgroundColor: Theme.of(context).cardColor,
        textColor: AppColors.whiteColor);
        //todo : back to home screen (pop)
      },)
          .catchError((error) {
        ToastUtils.toastMsg(
            msg: error.toString(),
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor);

          },
      );
    }
  }

  void chooseDate() async{
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    selectedDate = chooseDate;
    if(selectedDate  !=null ){
      formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    setState(() {

    });
  }

  void chooseTime() async{
    var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    selectedTime = chooseTime ;
    if(selectedTime !=null){
      formatTime = selectedTime!.format(context);
    }
    setState(() {

    });
  }
}
