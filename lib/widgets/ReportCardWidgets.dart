import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtualworkng/model/StaffReportModel.dart';
import 'package:virtualworkng/style/AppColor.dart';

class ReportCardWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  // final formatAmounts = new NumberFormat("#,##0.00", "en_US");

  const ReportCardWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ReportCardWidgetState createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
  final formatAmounts = new NumberFormat("#,##0.00", "en_US");
  String myStatus = '';

  @override
  Widget build(BuildContext context) {
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
              itemCount: (getReport().length > 10 ? 5 : getReport().length),
              itemBuilder: (context, index) {
                return Container(
                  child:  (getReport().length > 0 ? GestureDetector(
                    child: Container(
                        child: ListTile(
                          dense: true,
                          trailing: Column(
                            children: <Widget>[
                              checkIcon(getReport()[index].status),
                              Text(checkString(getReport()[index].status))
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
                                  color: AppColor.primaryColorDark,
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
                              Text(
                              getReport()[index].project,
                                style: TextStyle(
                                    inherit: true,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0),
                              ),
                              SizedBox(width: 50.0,),

                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(getReport()[index].period,
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
                        )
                    ),
                  )
                      : getInformationMessage('No Latest Transaction')),
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
        return  'Delivered';
        break;

      default:
        return '';
    }
  }

  int TransacStatus(String status) {
    switch (status) {
      case 'Successful':
        return 0;
        break;

      case 'Pending / Failed':
        return 1;
        break;
    }
  }

  Widget getStatusWidget (String status){

    if(TransacStatus(status) == 1){
      return Icon(
        Icons.error,
        size: 22.0,
        color: Colors.red,
      );
    }else{
      return Icon(
        Icons.check,
        size: 22.0,
        color: Colors.green,
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