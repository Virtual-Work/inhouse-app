import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';

class DeleteStaffDialog extends StatefulWidget {

  final String email;

  DeleteStaffDialog({this.email});

  @override
  _DeleteStaffDialogState createState() => _DeleteStaffDialogState();
}

class _DeleteStaffDialogState extends State<DeleteStaffDialog> {
bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              )
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(radius: 40, backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.outlined_flag, size: 30, color: AppColor.thirdColor,)
              ),
              SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Confirm to Delete", style: TextStyle(color: Colors.white, fontSize: 15.0,
                        fontWeight: FontWeight.bold) ),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[

                      Expanded(
                        child: RaisedButton(
                          child: Icon(Icons.close),
                          color: Colors.red,
                          colorBrightness: Brightness.dark,
                          onPressed: (){Navigator.pop(context);},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          child: Icon(Icons.done),
                          color: Colors.green,
                          colorBrightness: Brightness.dark,
                          onPressed: (){
                            deleteStaff(context, widget.email);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ],),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteStaff(BuildContext co, email) async {
    Navigator.pop(co);
   api.delete_And_Archive_StaffData(email: email).then((v){
     if (v != null) {
       // print(v.documentID);
       stopLoading();
     } else {
       stopLoading();

//       Navigator.pop(context);
     }
   });
    customF.showToast(message: '$email Successfully Removed');
  }

  startLoading(){
    setState(() {
      processing = true;
    });
  }

  stopLoading(){
    setState(() {
      processing = false;
    });
  }

}
