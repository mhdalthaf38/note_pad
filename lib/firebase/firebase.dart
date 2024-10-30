import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  //add data to firebase
   addToFirebase({
    required title,
    required notes
  }){
    try {

      FirebaseFirestore.instance.collection('notes').doc().set({
'title':title,
'content': notes
      });
    } catch (e) {
      print('error to add the data: $e');
    }
  }

  //firebase update

   updateData({
    required title,
    required notes,
    required id
  }){
    try {

      FirebaseFirestore.instance.collection('notes').doc(id).update({
'title':title,
'content': notes
      });
    } catch (e) {
      print('error to add the data: $e');
    }
  }
}