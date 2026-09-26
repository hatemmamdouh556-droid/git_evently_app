//todo : write data , read data, update data ,delete data

//todo firebase sdk => Classes =>function
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_project/model/event.dart';
import 'package:evently_project/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {

  static String getCurrentUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  //todo : user collection
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot, options) =>
            MyUser.fromJosnFireStore(snapshot.data()!),
        toFirestore:(user, options) => user.toJsonFireStore());
  }

  //todo :add user = write data
  static Future<void>addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);

  }
  //todo :add user data = read data
  static Future<MyUser?> readUserFromFireStore(String uId)async{
    var querySnapShot = await getUserCollection().doc(uId).get();
    return querySnapShot.data();
  }

  //todo : event collection => (users/{uid}/events)
  static CollectionReference<Event> getEventCollection(){
    String uid = getCurrentUid();
    return getUserCollection()
        .doc(uid)
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
  //todo : get data => one time read
  // void getAllEvents1()async{
  //   QuerySnapshot<Event>querySnapshot =await FirebaseUtils.getEventCollection().get();
  //   eventList = querySnapshot.docs.map((doc){
  //     return doc.data();
  //   }).toList() ;
  //   setState(() {
  //
  //   });
  //
  // }

  //todo : get data =>real time changes
  static Stream<List<Event>> getAllEvents(){
    return FirebaseUtils.getEventCollection()
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot){
      return querySnapshot.docs.map((doc){
        return doc.data();
      }).toList();
    });


  }
  //todo : get data =>real time changes
  static Stream<List<Event>> getFilterEvents({required int selectedIndex}){
    return FirebaseUtils.getEventCollection()
        .where('event_category_index',isEqualTo:selectedIndex )
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot){
      return querySnapshot.docs.map((doc){
        return doc.data();
      }).toList();
    });


  }
  //todo : update document
  static Future<void> updateIsFavorite (Event event){
    return getEventCollection().doc(event.id).update({'event_isFavorite' : !event.isFavorite});

  }
//todo : get isFavorite

  static Stream<List<Event>> getAllFavoriteEvents(){
    return getEventCollection().where('event_isFavorite',isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapShot){
      return querySnapShot.docs.map((doc){
        return doc.data();
      }).toList();
    });
  }
//todo : get single event by id = one time read
  static Future<Event?> getEventById(String eventId) async {
    var docSnapshot = await getEventCollection().doc(eventId).get();
    return docSnapshot.data();
  }
  //todo : delete document = delete data
  static Future<void> deleteEvent(Event event) {
    return getEventCollection().doc(event.id).delete();
  }
  //todo : update document (full event update)
  static Future<void> updateEvent(Event event) {
    return getEventCollection().doc(event.id).update(event.toJsonFireStore());
  }
  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        MyUser? existingUser = await readUserFromFireStore(user.uid);
        if (existingUser == null) {
          MyUser newUser = MyUser(
            id: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
          );
          await addUserToFireStore(newUser);
        }
      }

      return user;
    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
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