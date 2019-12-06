import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtualworkng/model/StafftransactionsModel.dart';
import 'package:virtualworkng/style/AppColor.dart';

class TransactionCardWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

 // final formatAmounts = new NumberFormat("#,##0.00", "en_US");

  const TransactionCardWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _TransactionCardWidgetState createState() => _TransactionCardWidgetState();
}

class _TransactionCardWidgetState extends State<TransactionCardWidget> {
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
              itemCount: (getTransact().length > 10 ? 5 : getTransact().length),
              itemBuilder: (context, index) {
                return Container(
                  child:  (getTransact().length < 10 ? GestureDetector(
                    child: Container(
                        child: ListTile(
                          dense: true,
                          trailing: Column(
                            children: <Widget>[
                              checkIcon(getTransact()[index].network),
                              Text(checkString(getTransact()[index].network))
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
                                  color: ChangeColor(getTransact()[index].network),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Row(
                            children: <Widget>[
                              Text(
                                'N' + formatAmounts.format(double.parse(getTransact()[index].amount)),
                                style: TextStyle(
                                    inherit: true,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),

                              ),
                              SizedBox(width: 50.0,),

                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(getTransact()[index].phoneno,
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

  Color ChangeColor(String network) {

    switch (network) {
      case 'MTN':
        return Color(0xFFB6900B);
        break;

      case 'GLO':
        return Color(0xFF006E52);
        break;

      case 'AIRTEL':
        return Color(0xFFED1B24);
        break;

      case 'GLO':
        return Color(0xFF4E8A41);
        break;

      case 'gift':
        return Color(0xFFFB8C0C);
        break;

      case 'GOTV':
        return Color(0xFFff310f);
        break;

      case 'dstv':
        return Color(0xFF0098DA);
        break;

      case 'startimes':
        return Color(0xFFEC690F);
        break;

        case 'WAEC':
        return Colors.yellow;
        break;

        case 'SMILE':
         return Colors.lightGreen;
        break;

        case 'Bank':
          return Colors.pink;
        break;

      default:
        return Colors.purpleAccent;
    }
  }

  Icon checkIcon(String network) {
    switch (network) {
      case 'MTN':
        return Icon(
          Icons.error_outline,
          size: 22.0,
          color: Color(0xFFB6900B),
        );
        break;

      case 'GLO':
        return  Icon(
          Icons.done_all,
          size: 22.0,
          color: Color(0xFF006E52),
        );

        break;

      case 'AIRTEL':
        return  Icon(
          Icons.error,
          size: 22.0,
          color: Color(0xFFED1B24),
        );
        break;

      default:
        return Icon(
          Icons.account_balance_wallet,
          size: 22.0,
          color: AppColor.primaryColorDark,
        );
    }
  }

  String checkString(String network) {
    switch (network) {
      case 'MTN':
        return 'Pending';
        break;

      case 'GLO':
        return  'Delivered';

        break;

      case 'AIRTEL':
        return  'Failed';
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
      style: TextStyle( fontWeight: FontWeight.w900, color: Colors.grey[100]),));
  }
}