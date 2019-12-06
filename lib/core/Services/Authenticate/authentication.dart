import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtualworkng/model/UserModel.dart';


class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;


User _userFromFirebaseUser({FirebaseUser user}){
  return user != null ? User(uID: user.uid) : null;
}

  //SigIn Anonymously,
  Future signInAnonymous () async{

    try{
       AuthResult _result =  await _auth.signInAnonymously();
       FirebaseUser _user = _result.user;
       //print('** USER ID ${_user.uid}');
       return _userFromFirebaseUser(user: _user);
    }catch(e){ //If there's an Error 
    print('******signInAnonymous ERROR ${e.toString()}');
    return null;
    }
  }


  //Auth chanege User Stream(checking if user logs in or not)
  Stream<User> get isUserLoggedIn{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => 
    _userFromFirebaseUser(user: user));
  }
  

  //SigIn in with email and password
   Future registerwithEmailandPassword() async{

    try{
       AuthResult _result =  await _auth.signInAnonymously();
       FirebaseUser _user = _result.user;
       //print('** USER ID ${_user.uid}');
       return _userFromFirebaseUser(user: _user);
    }catch(e){ //If there's an Error 
    print('******signInAnonymous ERROR ${e.toString()}');
    return null;
    }
  }

   //Sign Out
   Future signOut()async{
     try{
        return await _auth.signOut();

     }catch(e){
    print('******signInAnonymous ERROR ${e.toString()}');
    return null;
     }
   }
}