import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';

class deleteProjectDialog extends StatefulWidget {
String projectName;
deleteProjectDialog({this.projectName});

  @override
  _deleteProjectDialogState createState() => _deleteProjectDialogState();
}

class _deleteProjectDialogState extends State<deleteProjectDialog> {
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
                child: Icon(Icons.cancel, size: 30, color: AppColor.thirdColor,)
              ),
              SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Delete Project", style: TextStyle(color: Colors.white, fontSize: 20.0,
                        fontWeight: FontWeight.bold) ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text(
                          "Do you want to delete this Project?", style: TextStyle(color: Colors.white),),
                    ),
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
                            deleteP(context);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ],)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteP(BuildContext co) async {
    Navigator.pop(co);
    api.deleteProject(projectName: widget.projectName).then((v){
      if (v != null) {
        // print(v.documentID);
        stopLoading();
      } else {
        stopLoading();
      }
    });
    customF.showToast(message: '${widget.projectName} Successfully Delete');
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
