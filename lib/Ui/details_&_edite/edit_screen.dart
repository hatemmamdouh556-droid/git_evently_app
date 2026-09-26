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

class EditScreen extends StatefulWidget {
  final Event event;
  EditScreen({super.key,required this.event});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String title = '';
  String description = '';
  DateTime? selectedDate ;
  String formatDate ='' ;
  TimeOfDay? selectedTime;
  String formatTime ='' ;
  String selectedEventName ='' ;
  String selectedEventImage ='' ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.event.eventTitle);
    descriptionController = TextEditingController(text: widget.event.eventDescription);
    title = widget.event.eventTitle;
    description = widget.event.eventDescription;
    selectedDate = widget.event.eventDate;
    selectedTime = TimeOfDay.fromDateTime(widget.event.eventDate);
    selectedIndex = widget.event.eventCategoryIndex - 1;
    formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);

  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    formatTime = selectedTime!.format(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    selectedEventImage = themeProvider.isDark ?
    eventImageDark[selectedIndex]:
    eventImageLight[selectedIndex];


    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.update_event,
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
                  controller: titleController,
                  style: Theme.of(context).textTheme.bodySmall,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.title,
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
                  controller: descriptionController,
                  style: Theme.of(context).textTheme.bodySmall,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.description,
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
                  onPressed: updateEvent,
                  child: Text(
                    AppLocalizations.of(context)!.update_event,
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
  void updateEvent(){
    if (formKey.currentState?.validate() == true){
      Event updateEvent =Event(
          id: widget.event.id,
          eventImage: selectedEventImage,
          eventName: widget.event.eventName,
          eventTitle: titleController.text,
          eventDescription: descriptionController.text,
          eventDate: DateTime(
            selectedDate!.year, selectedDate!.month, selectedDate!.day,
            selectedTime!.hour, selectedTime!.minute,
          ),
          isFavorite: widget.event.isFavorite,
          eventCategoryIndex: selectedIndex + 1);
      FirebaseUtils.updateEvent(updateEvent).then((Value){
        ToastUtils.toastMsg(
          msg: 'Event updated successfully.',
          backgroundColor: Theme.of(context).cardColor,
          textColor: AppColors.whiteColor,);
        Navigator.pop(context);
      }).catchError((error) {
        ToastUtils.toastMsg(
          msg: error.toString(),
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor,);
      });

    }
  }
}
