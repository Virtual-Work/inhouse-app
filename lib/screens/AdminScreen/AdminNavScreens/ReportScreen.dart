//******************************************************************************************************************
//*******************Display List of Project and click on project name to submit Report**********************************
///**********************************************************************************************************************
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/TitleView.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/AdminReportWidgets.dart';

var customF = locator<CustomFunction>();
var api = locator<Api>();

//Display List of Report Submitted by staffs and Supervisors
class AdminReportsScreen extends StatefulWidget {
  AnimationController animationController;

  AdminReportsScreen(this.animationController);

  @override
  _AdminReportsScreenState createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> with TickerProviderStateMixin{

  Animation<double> topBarAnimation;
  // var customFunction = locator<CustomFunction>();
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;
  String mail;

  @override
  void initState() {
    getEmail();
    widget.animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

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
    //TextView UI with Animation
    listViews.add(
      TitleView(
        titleTxt: 'Tap on each Report to View Details',
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    //Report View UI with Animation
    listViews.add(
      AdminReportWidgets(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    // Adding a space btw UI
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
      backgroundColor: AppColor.lightText,
      body: StreamProvider<QuerySnapshot>.value(
        value: api.getReportsIds(),
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
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                );
              }
            }
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: AppColor.nearlyDarkBlue,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(FontAwesomeIcons.moneyBill),
              backgroundColor: Colors.green,
              label: 'Send Fund',
              labelStyle: AppTextStyle.headerSmall(context),
              onTap: (){
                _sendFunds(context);
              }
          ),
        ],
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
              top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
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
                          color: AppColor.primaryColorDark.withOpacity(0.4 * topBarOpacity),
                          offset: Offset(1.1, 1.1), blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
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
                                  "Submitted Reports",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppColor.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14 + 6 - 6 * topBarOpacity,
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
                                    Icons.report,
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
                                  Icon(Icons.report,color: AppColor.grey,)
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

  getEmail()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString(StaffEmail);
    });
  }

  _sendFunds(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
                return SendFunds(stateSetter: state,);
              });
        });
  }
}
class SendFunds extends StatefulWidget {
  final StateSetter stateSetter;
  SendFunds({this.stateSetter});

  @override
  _SendFundsState createState() => _SendFundsState();
}

class _SendFundsState extends State<SendFunds> {
  List<String> _supervisors = new List<String>();
  String _selectedSepervisors;
  bool processing = false;
  TextEditingController projectCommentController = TextEditingController();
  TextEditingController amountsController = TextEditingController();
  String formattedDate,formattedTime;

  @override
  void initState() {
    super.initState();
    todayDate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.getListOfStaffsFuture(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            customF.errorWidget(snapshot.error.toString());
          return snapshot.hasData
              ? SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom),
              child: Column(
                children: <Widget>[
                  addToList(snapshot), //Adding toList
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: AppColor.primaryColorDark,
                    child: Center(child: Text('Send Funds',
                      style: AppTextStyle.headerSmall2(context),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: amountsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Amounts',
                        labelStyle: AppTextStyle.inputLabelStyle(context),
                        hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      ),

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: projectCommentController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Comment(Optional)',
                        labelStyle: AppTextStyle.inputLabelStyle(context),
                        hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FindDropdown(
                    items: _supervisors,
                    label: "Select Supervisor",
                    onChanged: (value) {
                      _selectedSepervisors = value;
                    },
                    selectedItem: 'staff@virtualwork.ng',
                    validate: (String item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Adobe")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  processing ? CircularProgressIndicator(
                    backgroundColor: AppColor.deep00,) : RaisedButton(
                    child: Text("Send"),
                    splashColor: AppColor.orange,
                    elevation: 10,
                    animationDuration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: AppColor.primaryColorDark,
                    textColor: Colors.white,
                    onPressed: () {
                      sendFundApi();
                    },
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ) : //(snapshot.data.documents):
          customF.loadingWidget();
        }
    );
  }

  startLoading() {
    widget.stateSetter(() {
      processing = true;
    });
  }

  stopLoading() {
    widget.stateSetter(() {
      processing = false;
    });
  }
  //Fetching Staff that container Supervisor privilege and display as Dropdown
  addToList(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (_supervisors != null) {
      _supervisors.clear();
    }
    // print("************ Emails ***********");
    for (var doc in snapshot.data.documents) {
      if (doc.data['privilege'] ==
          'Staff') { //If priviledge is Staff don't display the Email

      } else {
        // print('${doc.data['Email']} = ${doc.data['privilege']}');
        _supervisors.add(doc.documentID);
      }
    }
    return SizedBox();
  }

  show(DocumentSnapshot data) {
    print(data['Wallet_balance']);
    return Text('Value');
  }

  sendFundApi(){
    String pComment = projectCommentController.text.trim();
    String amt = amountsController.text.trim();
    String supervisor =  _selectedSepervisors;

    if (amt.isEmpty) {
      customF.showToast(message: 'Empty field detected');
    } else {
    var conAmt = int.parse(amt); //Convert Amount Controller to Int;

  startLoading();
      api.getStaffWalletBalance(mail: _selectedSepervisors).then((v) {
        if (v != null) {
          var previousBal = v.data['Wallet_balance'];
          api.sendFunds(mail: _selectedSepervisors,  newAmounts: conAmt, previousAmount:
          previousBal, time: formattedTime, date: formattedDate).then((v){

            if (v != null) {
              stopLoading();
              customF.showToast(message: 'Error, Please Try Again.');
            } else {
              stopLoading();
              customF.showToast(message: 'Funds sent');
              Navigator.pop(context);
            }
          });

        } else {
          stopLoading();
          customF.showToast(message: 'Server error, Please retry');
          Navigator.pop(context);

        }
      });
//    }
  }
  }

  todayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy'); //Current Date
    formattedDate = formatter.format(now);
    formattedTime = DateFormat('K:mm:a').format(now); //Current Time kk:mm:a(24 hours format) K:mm:a = 24 hr format

  }

}
