
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
class Api {
  final databaseReference = Firestore.instance;

  DocumentReference documentReference;
  // final String path;
  CollectionReference collectionReference;

  Future<QuerySnapshot> Authentication(){
   try{
     return databaseReference.collection('Authentication').getDocuments();
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
  Future<QuerySnapshot> staffSignIn({String email}){
    try{
     return databaseReference.collection('Staffs').where('Email', isEqualTo: email).getDocuments();//.then((v){
//        print("FFHFHFHF");
//        v.documents.forEach((f) => f.documentID
//        ); //print('${}'));
     // });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //After successful Login by Staff, Staff can now create his/her own password
  Future createPIN({String staffEmail, password}) async{
    try{
      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'Password': password
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  //Stream
  Stream<QuerySnapshot> getListOfStaffs() {
    try{
      return databaseReference.collection('Staffs').snapshots(); //getDocuments().asStream()
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
//    List<String> addprojects() {
//      // Somehow implement it so it returns a List<String> based on your fields
//      return ['project1','project2','project3'];
//    }
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

  Future editStaff({String staffEmail, priviledge}) async{
    try{
      return databaseReference.collection("Staffs").document(staffEmail).updateData({
        'privilege': priviledge,
      });
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Stream<QuerySnapshot> getProjects(){
    try{
      return databaseReference.collection('Project').snapshots();
      //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future<QuerySnapshot> getProjectsFuture(){
    try{
      return databaseReference.collection('Project').getDocuments();
      //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future addProject({String projectName, projectTitle, supervisor, createdDate}) async{
    try{
      return databaseReference.collection("Project").document(projectName).setData({
        'Title': projectTitle,
        'status': true,
        'supervisor': supervisor,
        'DateCreated': createdDate,
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

