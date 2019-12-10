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
    final _media = MediaQuery.of(context).size;
    //print(documents[0].data['Lastname']);
//   final snapshot = documents.;
//    var documents = snapshot.documents;
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
//      SlidingUpPanel(
//        isDraggable: true,
//        panel: _floatingPanel(documents, clicked.getindexClicked, context, _media),
//        collapsed: _floatingCollapsed(documents, clicked.getindexClicked, context),
//               )
      ],
        );
  }


  Widget _floatingCollapsed(List<DocumentSnapshot> documents, int index, BuildContext context){
    String email = documents[index].data['Email'].toString();
  return Container(
    decoration: BoxDecoration(
      color: AppColor.nearlyDarkBlue,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), 
      topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    child: Center(
      child: Text('$email',
        style: AppTextStyle.headerSmallWhite(context)
      ),
    ),
  );
}

Widget _floatingPanel(List<DocumentSnapshot> documents, int index, BuildContext context, _media){
  String email = documents[index].data['Email'].toString();
  final String firstName = documents[index].data['Firstname'].toString(),
      lastName = documents[index].data['Lastname'].toString(),
      privilege =  documents[index].data['privilege'].toString();

  final List<dynamic> projects = documents[index].data['Projects'];

  //pix,

  return Container(
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ]
    ),
    margin: const EdgeInsets.all(14.0),
    child: Center(
      child:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AvatarGlow(
                        startDelay: Duration(milliseconds: 1000),
                        glowColor: AppColor.white,
                        endRadius: 60.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: CircleAvatar(
                          backgroundColor:Colors.orange ,
                          child: Image.asset('assets/images/img/userimage.jpg',height: 60, fit: BoxFit.cover,),
                          radius: 50.0,
                        ),
                        shape: BoxShape.circle,
                        animate: true,
                        curve: Curves.fastOutSlowIn,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Dialog(
                            elevation: 10,
                            shape: OutlineInputBorder(),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left:16.0, right: 16.0, bottom: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child:Text((email != null ? "Email: ${email}" : ''),
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child:  Text(firstName != null ? "Firstname: ${firstName}" : '',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: Text(lastName != null ? "Last Name: ${lastName}" : '',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: Text(privilege != null ? 'Priviledge : ${privilege}' : '',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: Text('Sometime:',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),

                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: Text('Phone No',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                      ],
                                    )
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('Projects', style: AppTextStyle.headerSmall2(context),)
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              height: screenAwareSize(
                  _media.longestSide <= 775 ? 80 : 240, context),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll){
                  // ignore: missing_return
                  overscroll.disallowGlow();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  //                child: Dialog(
//                    elevation: 10,
//                    shape: OutlineInputBorder(),
//                    child: ListView.separated(
//                  itemCount: projects.length == null ? 0 : projects.length,
//                  itemBuilder: (BuildContext context, index){
//                  return Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: ListTile(
//                      dense: true,
//                      leading: Icon(FontAwesomeIcons.file),
//                      title: Text((projects[index] == null ? '' : projects[index]), style: AppTextStyle.emailheaderSmall(context),),
//                      //  trailing: GestureDetector(
//                      //    child: (deleteprocessing ? Icon(Icons.delete, color: Colors.red,) :
//                      //     customF.loadingWidget()
//                      //    ),
//                      //    onTap: (){
//                      //      deleteProject(projects[index]);
//                      //    },
//                      //  ),
//                    ),
//                  );
//        }, separatorBuilder: (BuildContext context, int index) => Divider(
//          color: Colors.black,
//      )
//    )
//                ),
                child: projectListView(projects),
                ),
              ),
            ),
          ],
        ),
      )
    ),
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
