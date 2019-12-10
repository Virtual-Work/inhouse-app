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

class ListofArchieveWidgets extends StatelessWidget {

   List<DocumentSnapshot> documents = List<DocumentSnapshot>();

  ListofArchieveWidgets(this.documents);

  @override
  Widget build(BuildContext context){
    final _media = MediaQuery.of(context).size;

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
          )
        ),
        onTap: (){

        },
      );
    }),
      ],
        );
  }
}
