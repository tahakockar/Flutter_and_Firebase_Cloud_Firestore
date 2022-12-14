import 'package:cloud_firestore/cloud_firestore.dart';


class DataBase {
  String id;
   String Text;



  DataBase({required this.id,required this.Text});

  factory DataBase.fromSnapshot(DocumentSnapshot snapshot){
    return DataBase(
      id:snapshot.id,
      Text: snapshot["Text"]
    );
  }

  }
