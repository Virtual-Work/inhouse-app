import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/StafftransactionsModel.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/util/customFunctions.dart';

var customF = locator<CustomFunction>();

class TransactionCardWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

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
                return Container(
                    child: ListTile(
                      dense: true,
                      trailing: Column(
                        children: <Widget>[
                          customF.transactionIcon(snapshot.documents[index].data['status']),
                          Text(customF.transactionStatus(snapshot.documents[index].data['status']))
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
                              color: customF.transactionIconColor(snapshot.documents[index].data['status']),
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
                            'N' + formatAmounts.format(double.parse(snapshot.documents[index].data['Amount'])
                            ),
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
                            Text(snapshot.documents[index].data['Bank'],
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