import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/TitleView.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/StaffWalletView.dart';
import 'package:virtualworkng/widgets/TransactionCard.dart';
import '../../LoginScreen.dart';

var customF = locator<CustomFunction>();

class StaffWallet extends StatefulWidget {
  AnimationController animationController;
  StaffWallet(this.animationController);

  @override
  _StaffWalletState createState() => _StaffWalletState();
}

class _StaffWalletState extends State<StaffWallet> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;
  String mail;

  @override
  void initState() {
    widget.animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    getEmail();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    var count = 5;
    listViews.add(
      TitleView(
        titleTxt: 'Your withdrawal plan is bi-monthly',
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      StaffWalletView(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
                (1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      tranTitle(),
    );
    listViews.add(
      TransactionCardWidget(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
                (1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
        SizedBox(height: 100,)
    );
  }
  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<QuerySnapshot>.value(
        value: api.getTransactions(email: 'horlaz229@virtualwork.ng'),
        child: Builder(
            builder: (context){
              var snapshot = Provider.of<QuerySnapshot>(context);
              if(snapshot == null){
                return customF.loadingWidget();
              }else{
                return Stack(
                  children: <Widget>[
                    getMainListViewUI(),
                    getAppBarUI(),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .padding
                          .bottom,
                    )
                  ],
                );
              }
            }
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + MediaQuery
                  .of(context)
                  .padding
                  .top,
              //bottom: 19 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColorDark.withOpacity(topBarOpacity),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppColor.primaryColorDark.withOpacity(
                              0.4 * topBarOpacity),
                          offset: Offset(1.1, 1.1), blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .padding
                            .top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Wallet",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppColor.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppColor.nearlyBlack,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 1,
                                right: 1,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.wallet,
                                    color: AppColor.grey,)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget tranTitle() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 25.0, right: 10, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Transaction History",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.27,
              color: AppColor.darkerText,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.list,
            color: AppColor.primaryColorDark,
            size: 25,
          ),
        ],
      ),
    );
  }

  getEmail()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString(StaffEmail);
    });
  }
}