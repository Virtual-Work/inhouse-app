import 'package:flutter/material.dart'; //
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dialogs/single_choice_confirmation_dialog.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
//******************************************************************************************************************
//*******************ViewReport Widgets **********************************
///**********************************************************************************************************************
class ViewReportWidgets extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ViewReportWidgets({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ViewReportWidgetsState createState() => _ViewReportWidgetsState();
}

class _ViewReportWidgetsState extends State<ViewReportWidgets> {
  String myStatus = '';

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);

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
              itemCount: (snapshot.data.length == null ? 0 : snapshot.data.length),
              itemBuilder: (context, index) {
                return Container(
                    child: ListTile(
                      dense: true,
                      trailing: Column(
                        children: <Widget>[
                        Icon(
                        Icons.report, size: 22.0, color: Color(0xFFB6900B),
                      ),
                          Text(customF.reportStatus(snapshot.data['status']))
                        ],
                      ),
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
                              color: Color(0xFFB6900B),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Icon(
                                Icons.report,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(snapshot.data['ProjectName'],
                            style: TextStyle(inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
                          ),
                          SizedBox(width: 50.0,),
                        ],
                      ),
                      subtitle: Text('From: ${snapshot.data['Time from']} To: ${snapshot.data['Time To']}',
                          style: TextStyle(
                          inherit: true,
                          fontSize: 9.0,
                          color: Colors.black87)),
                    )
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
}