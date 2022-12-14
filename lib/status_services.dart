import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_flutter/data.dart';


class StatusServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addStatus(String Text) async{
    var ref = _firestore.collection("Status");

    var documentRef = await ref.add({
      'Text' : Text,
      }
    );

    return DataBase(id:documentRef.id, Text:Text,);
  }


  // veri Gösterme fonksiyonu
Stream<QuerySnapshot> getStatus(){
    var ref = _firestore.collection("Status").snapshots();
    return ref;
}


// veri  silme

Future removeStatus(String docId)async {
  var ref = _firestore.collection("Status").doc(docId).delete();

  return ref;
}


// Veri güncelleme
  Future UpdateStatus(String docId,newData)async {
    var ref = _firestore.collection('Status').doc(docId).update(newData);


    return ref;
  }

}