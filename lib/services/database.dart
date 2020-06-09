

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  
  //collection reference
final CollectionReference brewCollection = Firestore.instance.collection('brews');

Future updateUserData(String sugar,String name, int strength) async{
  return await brewCollection.document(uid).setData({
    'sugar':sugar,
    'name' : name,
    'strength' : strength,
  });
}

//get brews stream

Stream<QuerySnapshot> get brews{
  return brewCollection.snapshots();
}

}


