import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtualworkng/model/StaffReportModel.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

//******************************************************************************************************************
//*******************Report UI or Widget**********************************
///**********************************************************************************************************************
class ReportCardWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ReportCardWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ReportCardWidgetState createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {

  String myStatus = '';

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<QuerySnapshot>(context);

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
                var count = snapshot.documents.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                return ReportView(
                  documentID: snapshot.documents[index].documentID,
                  dateCreated: snapshot.documents[index].data['DateCreated'],
                  animation: animation,
                  animationController: widget.animationController,
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
class ReportView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String documentID, dateCreated;

  const ReportView({
    Key key,
    this.animationController,
    this.animation,
    this.documentID,
    this.dateCreated
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              child: Container(
                  child: ListTile(
                    dense: true,
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
                        documentID == null ? '' : documentID,
                        style: AppTextStyle.headerSmall3(context)
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(dateCreated == null ? ''
                              : 'Created : $dateCreated',
                              style: TextStyle(
                                  inherit: true,
                                  fontSize: 10.0,
                                  color: Colors.black45)),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    enabled: true,
                  )
              ),
              onTap: (){
                //Go to Submit Report UI
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SubmitReportUI(projectSelected: documentID),
                  ),
                );
              },
            )
          ),
        );
      },
    );
  }
}
