class MyUser {
  //todo : Collection
  static const String collectionName = 'Users';

  //todo : Attributes
  String id ;
  String name ;
  String email ;
  //todo : Constructor
  MyUser({required this.id,required this.name ,required this.email});

  //todo: json =>object
  MyUser.fromJosnFireStore(Map<String,dynamic>data):this(
    id:data ['id'],
    name: data['name'],
    email: data['email'],
  );
  //todo : object  => json
  Map<String,dynamic> toJsonFireStore(){
    return{
      'id' : id,
      'name' : name,
      'email' : email,
    };
  }
 }