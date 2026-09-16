import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  ///Collection Name
  static const String collectionName = 'Event';

  ///Attributes
  String id ;
  String eventImage ;
  String eventName ;
  String eventTitle ;
  String eventDescription ;
  DateTime eventDate  ;
  bool isFavorite;
  Event({
  this.id = '',
  required this.eventImage,
  required this.eventName,
  required this.eventTitle,
  required this.eventDescription,
  required this.eventDate,
    this.isFavorite = false,
});
  //todo : json => object
  Event.fromJsonFireStore(Map<String,dynamic> data ):this(
    id: data  ['id'],
    eventName: data['event_Name'],
    eventImage: data['event_image'],
    eventTitle: data['event_title'],
    eventDescription: data['event_Description'],
    eventDate:(data ['event_date'] as Timestamp).toDate(),
    isFavorite: data['event_isFavorite'],
  );
  //todo : object => json
  Map<String,dynamic> toJsonFireStore(){
    return {
      'id' :id ,
      'event_title' : eventTitle,
      'event_Name' : eventName,
      'event_Description' : eventDescription,
      'event_image' : eventImage,
      'event_date' : eventDate,
      'event_isFavorite' : isFavorite,
    };
  }
}