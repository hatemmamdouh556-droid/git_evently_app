//todo : write data , read data, update data ,delete data

//todo firebase sdk => Classes =>function
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_project/model/event.dart';

class FirebaseUtils {
  //todo : event collection
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJsonFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toJsonFireStore(),
        );
  }

  //todo : write data
  static Future<void> addEventToFireStore(Event event) {
    //todo : 1 - collection
    CollectionReference<Event> collectionRef = getEventCollection();
    //todo : 2 - document
    DocumentReference<Event> docRef = collectionRef.doc();
    //todo : auto id
    event.id = docRef.id;
    //todo : save data
    return docRef.set(event);
  }
}

//todo : Firebase Firestore => json => java script object notation => map => Key  , value
//todo : dynamic => string ,int ,double
//todo : Firebase => json
//todo : Developers =>object
//todo : json => object
//todo : object => json
//todo :  json => data
//todo :  object => add()
