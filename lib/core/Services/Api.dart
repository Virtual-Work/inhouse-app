
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminDasbhoardScreen.dart';
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


//***********************************************************************************
// **********************STAFF API**************************************************
// ***********************************************************************************

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

  //***********************************************************************************
// **********************PROJECT API**************************************************
// ***********************************************************************************

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


  //Future<QuerySnapshot> getTestProjectsFuture(){
  Future<QuerySnapshot>  getTestProjectsFuture()async{
    try{
      return  databaseReference.collection("Project").getDocuments();
      //getDocuments().asStream()
    }catch(e){
      print('******signInAnonymous ERROR ${e.toString()}');
      return null;
    }
  }

  Future addProjectDemo({String projectName, projectTitle, supervisor, createdDate}) async{
    try{
     var query1 = databaseReference.collection('Me').document(projectTitle);
     var query2 =   query1.collection(supervisor).add({
       'Title': projectTitle,
       'status': '0',
       'supervisor': supervisor,
       'DateCreated': createdDate,
     });



//     var set = query2.setData({
//       'Title': projectTitle,
//       'status': '0',
//       'supervisor': supervisor,
//       'DateCreated': createdDate,
//     });

     return query2;

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

