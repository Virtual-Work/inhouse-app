
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  // final String uid;
  // DatabaseService({this.uid});
//Database Reference
  final databaseReference = Firestore.instance;
  //Collection referrence
  final CollectionReference adminCollection = Firestore.instance.collection('AdminLogin');

  Future updateStaffData({String staffEmail, String staffPassword})async{
    // return await adminCollection.get(uid).setData({
    //   'AdminEmail' : staffEmail,
    //   'AdminPassword' : staffPassword,
    // });
    print(adminCollection.document('AdminLogin').collection('AdminLogin').id);
    return  adminCollection.document('AdminLogin').path;

  }
//
//  AdminAuth getData(){
//    AdminAuth auth;
//    databaseReference.collection("AdminLogin").getDocuments().then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f){
//        print('Here am I');
//
////        print('*****Admin Email********${f.data['AdminEmail']}}');
////        print('****Admin Password*********${f.data['AdminPassword']}}');
//      });
//    });
//  }

  Future<QuerySnapshot> data()async{
    return databaseReference.collection("AdminLogin").getDocuments();
  }

}