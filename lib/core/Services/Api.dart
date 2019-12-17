
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminDasbhoardScreen.dart';
class Api {
  final databaseReference = Firestore.instance;
  DocumentReference documentReference;
  // final String path;
  CollectionReference collectionReference;


  Future<QuerySnapshot> authentication({String email, password}){
    try{
      return databaseReference.collection('Authentication').where('Email',
          isEqualTo: email).getDocuments();
      // return databaseReference.collection('Authentication').getDocuments();

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future<QuerySnapshot> getA(){
    try{
      return databaseReference.collection('AdminLogin').getDocuments();
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }


//***********************************************************************************
// **********************STAFF API**************************************************
// ***********************************************************************************

  //After successful Login by Staff, Staff can now create his/her own password
  Future createPIN({String staffEmail, password}) async{
    try{
      return databaseReference.collection('Authentication').document(staffEmail).updateData({
        'Password': password,
        'isAdmin': false, //Am not an Admin, so I can't access admin UI
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future<QuerySnapshot> staffSignIn({String email}){
    try{
      return databaseReference.collection('Staffs').where('Email',
          isEqualTo: email).getDocuments();
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future addMoreDetailsToStaff({String staffEmail, fName, lName, phone, accountN, accountNo,
    bankName, withdrawalPlan, var file})async{

    try{
      final StorageReference storageRef = FirebaseStorage.instance.ref().child('Staff Pictures');
      var time = new DateTime.now();
      final StorageUploadTask uploadTask = storageRef.child(time.toString() + '.jpg').putFile(file);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      //print(imageUrl.toString());

      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Email': staffEmail,
        'Firstname' : fName,
        'Lastname' : lName,
        'PhoneNumber' : phone,
        'AccountName' : accountN,
        'AccountNumber' : accountNo,
        'BankName' : bankName,
        'WithdrawalPlan' : withdrawalPlan,
        'Picture' : imageUrl.toString(),
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future updateMoreDetailsToStaff({String staffEmail, fName, lName, phone, accountN, accountNo,
    bankName, withdrawalPlan, })async{ //var file
        //Am removing updating image for now..
    try{
//      final StorageReference storageRef = FirebaseStorage.instance.ref().child('Staff Pictures');
//      var time = new DateTime.now();
//      final StorageUploadTask uploadTask = storageRef.child(time.toString() + '.jpg').putFile(file);
//      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      //print(imageUrl.toString());

      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Email': staffEmail,
        'Firstname' : fName,
        'Lastname' : lName,
        'PhoneNumber' : phone,
        'AccountName' : accountN,
        'AccountNumber' : accountNo,
        'BankName' : bankName,
        'WithdrawalPlan' : withdrawalPlan,
       // 'Picture' : imageUrl.toString(),
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //Stream of Staffs, List of Staff
  Stream<QuerySnapshot> getListOfStaffs() {
    try{
      return databaseReference.collection('Staffs').snapshots(); //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }
//List of archive Staff, List of archive.
  Stream<QuerySnapshot> getListOfArchieve() {
    try{
      return databaseReference.collection('Archive').snapshots(); //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //Future builder
  Future<QuerySnapshot> getListOfStaffsFuture() {
    try{
      return databaseReference.collection('Staffs').getDocuments(); //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future addStaff({String staffEmail, priviledge}) async{
    try{
      return databaseReference.collection("Staffs").document(staffEmail).setData({
        'Email': staffEmail,
        'privilege': priviledge,
        'SearchKey': staffEmail.toUpperCase().substring(0, 1), //Email Sor details searchkey
        'PSearchKey': priviledge.toUpperCase().substring(0, 2,), //Preivilegde search key
        'Projects' : ['project1','project2','project3']
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future deleteProjectFromSupervisor({String projectName, String staffEmail}){
    try{
      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Projects' : FieldValue.arrayRemove([projectName])
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future addProjectToSupervisor({String projectName, String staffEmail}){
    try{
      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Projects' : FieldValue.arrayUnion([projectName])
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future edit_Update_Staff({String staffEmail, priviledge, fName, lName, phoneN}) async{
    try{
      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Firstname': fName,
        'Lastname': lName,
        'privilege': priviledge,
        'PSearchKey': priviledge.toUpperCase().substring(0, 2,), //priviledge search key,
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Stream<DocumentSnapshot> myDetails(String mail){
    try{
      return  databaseReference.collection('Staffs').document(mail).snapshots(); //getDocuments().asStream()

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future<DocumentReference>  delete_And_Archive_StaffData({String email}) async{
    try{
      await databaseReference.collection("Archive").document(email).setData({
        'Email': email,
        'SearchKey': email.toUpperCase().substring(0, 1),
      });
      databaseReference.collection('Staffs').document(email).delete();

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }


  uploadPicture(var file)async{
    final StorageReference storageRef = FirebaseStorage.instance.ref().child('Staff Pictures');
    var time = new DateTime.now();
    final StorageUploadTask uploadTask = storageRef.child(time.toString() + '.jpg').putFile(file);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(imageUrl.toString());
  }

  //***********************************************************************************
// **********************PROJECT API**************************************************
// ***********************************************imag************************************

  //Return Stream of getting Projects.....
  Stream<QuerySnapshot> getProjects(){
    try{
      return databaseReference.collection('Project').snapshots();
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //Return Future of getting Projects.....
  Future<QuerySnapshot> getProjectsFuture(){
    try{
      return databaseReference.collection('Project').getDocuments();
      //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }


  Future addProject({String comment, projectTitle, supervisor, createdDate, }) async{
   // title, status, comment (e.g links) to the database
    try{
      await databaseReference.collection('Project').document(projectTitle).setData({
        'Title': projectTitle,
        'status': '0',
        'Comment' : comment,
        'Supervisors': [supervisor],
        'DateCreated': createdDate,
      });
      //After that, Goto Staff Collection and Add this project to this Staff..
      databaseReference.collection("Staffs").document(supervisor).updateData({
        'Projects' : FieldValue.arrayUnion([projectTitle])
      });

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future editProject({String comment, projectName, newTitle}) async{
    // Edit Project name...project title and comment
    try{
      await databaseReference.collection('Project').document(projectName).updateData({
        'Title': newTitle,
        'Comment' : comment,
      });

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future<DocumentReference>  deleteProject({String projectName}) async{
    try{
      await databaseReference.collection('Project').document(projectName).delete();

    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }


  Future removeSupervisorFromProject({String projectName, String staffEmail}){
    try{
      return databaseReference.collection("Project").document(projectName).updateData({
        'Supervisors' : FieldValue.arrayRemove([staffEmail])
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //Assign a Project to a particular Supervisor
  Future assignProjectToStaff({projectTitle, supervisor, }) async{
    try{
      //First add this email to supervisorList
      databaseReference.collection("Project").document(projectTitle).updateData({
        'Supervisors' : FieldValue.arrayUnion([supervisor])
      });

      //After that, Goto Staff Collection and Add this project to this Staff..
      databaseReference.collection("Staffs").document(supervisor).updateData({
        'Projects' : FieldValue.arrayUnion([projectTitle])
      });



    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }


  //***********************************************************************************
// **********************TESTING API**************************************************
// ***********************************************************************************
//Storing data to subcollection.. This is working perfectly..
//  return  databaseReference.collection('Staffs').document("horlaz229@virtualwork.ng").
//  collection('Wallet').add({
//  'Balance': '23,000',
//  });

                //FETCHING DATA OF SUBCOLLECTION...
//  var query  = await databaseReference.collection('Staffs').document("horlaz229@virtualwork.ng").
//  collection('Wallet').getDocuments();
//
//  for(var d in query.documents){
//  print(d.data);
//  }
   testPassword() async{
    List<Tester> tester = Tester.testerList;
    try{
        return  databaseReference.collection('Staffs').
        document("horlaz229@virtualwork.ng").collection('Wallet').document('horlaz229@virtualwork.ng').updateData({
          'Balance': '13,000',
          'Amounts' : ['10000'],
           'Time' : ['9:00bn'],
           'Day' : ['Monday'],
  });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }
//  Future<void> removeDocument(String id){
//    return documentReference.document(id).delete();
//  }
//  Future<DocumentReference> addDocument(Map data) {
//    return documentReference.add(data);
//  }
//  Future<void> updateDocument(Map data , String id) {
//    return documentReference.document(id).updateData(data) ;
//  }

}

class Tester{
  String amount, time, day;

  Tester({this.amount, this.time, this.day});

  static List<Tester> testerList = [
    Tester(
      amount: '100',
      day: '12 days ago',
      time: '12:00pm'
    ),
    Tester(
        amount: '200',
        day: '14 days ago',
        time: '11:00pm'
    ),
    Tester(
        amount: '100',
        day: '15 days ago',
        time: '1:00pm'
    ),
  ];
}

