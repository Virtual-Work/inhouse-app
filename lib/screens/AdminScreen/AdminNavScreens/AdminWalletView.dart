import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class AdminWalletView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const AdminWalletView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _AdminWalletViewState createState() => _AdminWalletViewState();
}

class _AdminWalletViewState extends State<AdminWalletView> {
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 3),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColor.d,
                    AppColor.primaryColorDark,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColor.grey.withOpacity(0.6),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.wallet, color: AppColor.lightText,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          ('3,0000'), //
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppColor.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            letterSpacing: 0.0,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(),
                            Expanded(
                              child: SizedBox(
                              ),
                            ),
//                            GestureDetector(
//                              child: Container(
//                                decoration: BoxDecoration(
//                                  color: AppColor.nearlyWhite,
//                                  shape: BoxShape.rectangle,
//                                  boxShadow: <BoxShadow>[
//                                    BoxShadow(
//                                        color: AppColor.nearlyBlack
//                                            .withOpacity(0.4),
//                                        offset: Offset(8.0, 8.0),
//                                        blurRadius: 8.0),
//                                  ],
//                                ),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(10.0),
//                                  child: Text(
//                                      '', style:  AppTextStyle.headerSmall(context)
//                                  ),
//                                ),
//                              ),
//                              onTap: (){
//                                //_selectOption(context);
//                              },
//                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
