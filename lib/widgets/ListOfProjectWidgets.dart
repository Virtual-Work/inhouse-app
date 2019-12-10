import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualworkng/model/StaffReportModel.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/widgets/deleteProjectDialog.dart';

class ListOfProjectCards extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  // final formatAmounts = new NumberFormat("#,##0.00", "en_US");

  const ListOfProjectCards({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ListOfProjectCardsState createState() => _ListOfProjectCardsState();
}

class _ListOfProjectCardsState extends State<ListOfProjectCards> {
  final formatAmounts = new NumberFormat("#,##0.00", "en_US");
  String myStatus = '';

  @override
  Widget build(BuildContext context) {
       final snapshot = Provider.of<QuerySnapshot>(context);

     //  print(snapshot.documents[0].data['Title']);
//       print(snapshot.documents[0].data['status']);

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: (snapshot.documents.length == null ? 0 : snapshot.documents.length),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    child:  (snapshot.documents.length> 0 ? GestureDetector(
                      child: Container(
                          child: ListTile(
                            dense: true,
                            trailing: GestureDetector(child: Icon(Icons.delete, color: Colors.red,),
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return deleteProjectDialog(projectName: snapshot.documents[index].documentID.toString(),);
                                    });
                              },),
                            leading: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Material(
                                elevation: 10,
                                shape: CircleBorder(),
                                shadowColor: Color(0xFF63013C), //ChangeColor(transaction[index].network).withOpacity(0.4),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColorDark,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.solidFile,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              snapshot.documents[index].documentID == null ? '' : snapshot.documents[index].documentID,
                              style: AppTextStyle.headerSmall3(context)
                            ),
//                            subtitle: Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Text(snapshot.documents[index].data['DateCreated'] == null ? ''
//                                      : snapshot.documents[index].data['DateCreated'],
//                                      style: TextStyle(
//                                          inherit: true,
//                                          fontSize: 12.0,
//                                          color: Colors.black45)),
//                                  SizedBox(
//                                    width: 10,
//                                  ),
//                                ],
//                              ),
//                            ),
                            enabled: true,
                          )
                      ),
                    )
                        : getInformationMessage('No Latest Transaction')),
                  ),
                  onTap: (){
                    customF.detailsDialog(title:snapshot.documents[index].data['Title'],
                        status: snapshot.documents[index].data['status'],
                        supervisors: snapshot.documents[index].data['supervisor'],
                        context: context);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        );
      },
    );

  }

  Color ChangeColor(bool status) {

    switch (status) {
      case true:
        return Color(0xFF006E52);
        break;

      case false:
        return Color(0xFFED1B24);
        break;

      default:
        return Colors.purpleAccent;
    }
  }

  Icon checkIcon(bool status) {
    switch (status) {
      case true:
        return  Icon(
          Icons.done_all,
          size: 22.0,
          color: Color(0xFF006E52),
        );
        break;

      case false:
        return  Icon(
          Icons.error,
          size: 22.0,
          color: Color(0xFFED1B24),
        );
        break;

      default:
        return Icon(
          Icons.report,
          size: 22.0,
          color: AppColor.primaryColorDark,
        );
    }
  }

  String checkString(bool status) {
    switch (status) {
      case false:
        return 'Pending';
        break;

      case true:
        return  'Complete';
        break;

      default:
        return '';
    }
  }

  Widget getStatusWidget (bool status){
    if(status){ //If status is true
      return Icon(
        Icons.check,
        size: 22.0,
        color: Colors.green,
      );

    }else if(!status){ //If status is false
      return Icon(
        Icons.error_outline,
        size: 22.0,
        color: Colors.redAccent,
      );
    }
  }

  Widget getInformationMessage(String message){
    return Center(child: Text(message,
      textAlign: TextAlign.center,
      style: TextStyle( fontWeight: FontWeight.w900,
          color: Colors.orange),));
  }


}