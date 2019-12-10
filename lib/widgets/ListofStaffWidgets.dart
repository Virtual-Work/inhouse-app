import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:virtualworkng/model/UserModel.dart';
import 'package:virtualworkng/model/staffDetailsClicked.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/UpdateStaffDetails.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/screen_size.dart';
import 'package:virtualworkng/widgets/DeleteStaffDialog.dart';
import 'package:virtualworkng/widgets/StaffDetailsWidgets.dart';

class ListOfStaffWidgets extends StatelessWidget {

   List<DocumentSnapshot> documents = List<DocumentSnapshot>();
  ListOfStaffWidgets(this.documents);


  @override
  Widget build(BuildContext context){
    final clicked = Provider.of<StaffDetailsClicked>(context);
    return Stack(
        children: <Widget>[
         ListView.builder(
        itemCount: documents.length == null ? 0 : documents.length,
       itemBuilder: (BuildContext context, index){
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 3.0, bottom:5.0),
          child: ListTile(
            dense: true,
            leading: AvatarGlow(
              startDelay: Duration(milliseconds: 1000),
              glowColor: AppColor.thirdColor,
              endRadius: 30.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: CircleAvatar(
                backgroundColor:Colors.orange ,
                child: Image.asset('assets/images/img/userimage.jpg',height: 60, fit: BoxFit.cover,),
                radius: 20.0,
              ),
              shape: BoxShape.circle,
              animate: true,
              curve: Curves.fastOutSlowIn,
            ),
            title:  Text('Email: ${documents[index].data['Email'].toString()}',
              style: AppTextStyle.headerSmall(context),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Privilege: ${documents[index].data['privilege'].toString()}',
                      style: TextStyle(
                          inherit: true,
                          fontSize: 12.0,
                          color: Colors.black45)),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            trailing: GestureDetector(child: Icon(Icons.delete, color: Colors.red,),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteStaffDialog(email: documents[index].data['Email'].toString(),);
                  });
            },),
          )
        ),
        onTap: (){
//        clicked.setIndexClicked = index;
//        print(clicked.getindexClicked);
           showDialog(
               context: context,
               builder: (BuildContext context) {
                return StaffDetailsWidgets(email: documents[index].data['Email'].toString(),
                  firstName: documents[index].data['Firstname'].toString(),
                 lastName: documents[index].data['Lastname'].toString(),
                 //pix: documents[index].data['pic'].toString(),
                 privilege: documents[index].data['privilege'].toString(),
                projects: documents[index].data['Projects']
                 );});
        },
      );
    }),
      ],
        );
  }

  Widget projectListView(List<dynamic> project){
    print(project.runtimeType);
    return ListView.separated(
        itemCount: 0,
        itemBuilder: (BuildContext context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: true,
              leading: Icon(FontAwesomeIcons.file),
              title: Text('${project[index]}', style: AppTextStyle.emailheaderSmall(context),),
              //  trailing: GestureDetector(
              //    child: (deleteprocessing ? Icon(Icons.delete, color: Colors.red,) :
              //     customF.loadingWidget()
              //    ),
              //    onTap: (){
              //      deleteProject(projects[index]);
              //    },
              //  ),
            ),
          );

        }, separatorBuilder: (BuildContext context, int index) => Divider(
      color: Colors.black,
    )
    );
  }
}
