import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/StafftransactionsModel.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/util/screen_size.dart';
import 'package:virtualworkng/widgets/ListOfProjectWidgets.dart';
import 'package:virtualworkng/widgets/TransactionCard.dart';
import 'package:virtualworkng/widgets/donut_charts.dart';
import 'package:virtualworkng/widgets/logOut.dart';
import 'package:charts_flutter/flutter.dart' as charts;

var customF = locator<CustomFunction>();
var api = locator<Api>();

var data = [
  new DataPerItem('English', 35, Colors.greenAccent),
  new DataPerItem('Physics', 25, Colors.yellow),
  new DataPerItem('Mathematics', 24, Colors.indigo),
  new DataPerItem('Biology', 40, Colors.pinkAccent),
];
var series = [
  new charts.Series(
    domainFn: (DataPerItem clickData, _) => clickData.name,
    measureFn: (DataPerItem clickData, _) => clickData.percent,
    colorFn: (DataPerItem clickData, _) => clickData.color,
    id: 'Item',
    data: data,
  ),
];


class StaffDashboard extends StatefulWidget {
  AnimationController animationController;
  StaffDashboard(this.animationController);

  @override
  _StaffDashboardState createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> with TickerProviderStateMixin{
  final formatAmounts = new NumberFormat("#,##0.00", "en_US");
  String myStatus = '';
  String mail;
  @override
  void initState() {
    super.initState();
    getEmail();
    widget.animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
          stream: api.myDetails(mail),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError)
              customF.errorWidget(snapshot.error.toString());
            return snapshot.hasData
                ? dashboard(snapshot.data):
            customF.loadingWidget();
          }),
    );
  }

  dashboard(DocumentSnapshot snapshot){
    //Save details
    customF.saveStaffdetails(
      privilege: snapshot.data['privilege'],
      firstName:  snapshot.data['Firstname'],
      lastName:  snapshot.data['Lastname'],
    );
    final _media = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 20,
        top: 15,
      ),
      children: <Widget>[
        SizedBox(height: 20,),
        Stack(
          children: <Widget>[
            Positioned(
              left: 100.0,
              child: GradientText("VirtualWorkNG",
                  gradient: LinearGradient(
                      colors: [AppColor.rimary, AppColor.red,
                        Colors.orange]),
                  style: TextStyle(fontSize: 25,
                    fontFamily: "Lobster",),
                  textAlign: TextAlign.center),
            ),
            Positioned(child:
            GestureDetector(
              child: Icon(FontAwesomeIcons.signInAlt, color: Colors.redAccent, size: 30,),
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog();});
              },)
              ,),
          ],
        ),
        Row(
          children: <Widget>[
            colorCard("Projects", '1', 35.170, 1, context, AppColor.orange, 0),
            colorCard("Plan", 'Bi-Monthly', 4320, -1, context, AppColor.teal, 1),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Summary",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Varela",
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
            right: 20,
          ),
          height:
          screenAwareSize(_media.longestSide <= 775 ? 180 : 130, context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 6,
                spreadRadius: 10,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 180,
                width: 160,
                child: DonutPieChart(
                  series, animate: true,
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    donutCard(Colors.indigo, "Balance"),
                    donutCard(Colors.yellow, "Report"),
                    donutCard(Colors.greenAccent, "Task"),
                    donutCard(Colors.pinkAccent, "Disputes"),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 9,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Latest Transaction",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Varela",
                ),
              ),
            ],
          ),
        ),
        //Getting the latest Transaction from the Server
        Container(
          margin: EdgeInsets.only(left: 2),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              // ignore: missing_return
              overscroll.disallowGlow();
            },
            child:  StreamProvider<QuerySnapshot>.value(
              value: api.getTransactions(email: 'horlaz229@virtualwork.ng'),
              child: Builder(
                  builder: (context){
                    var snapshot = Provider.of<QuerySnapshot>(context);
                    if(snapshot == null){
                      return customF.loadingWidget();
                    }else{
                      return transactionUI(snapshot);
                    }
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget colorCard(String text, String no, double amount, int type, BuildContext context, Color color, int index) {
    final _media = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 15),
        padding: EdgeInsets.all(15),
        height: screenAwareSize(90, context),
        width: _media.width / 2 - 25,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 16,
                  spreadRadius: 0.2,
                  offset: Offset(0, 8)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (index == 0 ?  Center(child: Icon(FontAwesomeIcons.user, color: Colors.white,))
                :  Center(child: Icon(FontAwesomeIcons.fileImage, color: Colors.white,))),
            Center(
              child: Text(
                '$no $text',
                style:AppTextStyle.headerSmall2(context),
              ),
            )

          ],
        ),
      ),
      onTap: (){
      },
    );
  }

  Widget donutCard(Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 18,
            right: 10,
          ),
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            inherit: true,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        )
      ],
    );
  }

  //Getting the latest Transaction from the Server, this
  //is the UI for displaying the data
  transactionUI(QuerySnapshot snapshot){
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: (snapshot.documents.length >= 10 ? 10 : snapshot.documents.length), //Show 10 items
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
    );
  }

  getEmail()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString(StaffEmail);
    });
  }
}

