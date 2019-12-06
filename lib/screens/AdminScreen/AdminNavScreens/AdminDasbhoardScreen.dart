import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/screen_size.dart';
import 'package:virtualworkng/widgets/ListOfProjectWidgets.dart';
import 'package:virtualworkng/widgets/donut_charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:virtualworkng/widgets/logOut.dart';

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
class AdminDashboard extends StatefulWidget {
   AnimationController animationController;
   AdminDashboard(this.animationController);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with TickerProviderStateMixin {
  String myStatus = '';
  @override
  void initState() {
    widget.animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  dashboard(),
    );
  }

  dashboard(){
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
                colorCard("Staffs", '5', 35.170, 1, context, AppColor.orange, 0),
                colorCard("Projects", '3', 4320, -1, context, AppColor.teal, 1),
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
                      series,
                      animate: true,
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
                        donutCard(Colors.indigo, "Staff"),
                        donutCard(Colors.yellow, "Project"),
                        donutCard(Colors.greenAccent, "Report"),
                        donutCard(Colors.pinkAccent, "Disputes"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Latest Projects",
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
            Container(
              margin: EdgeInsets.only(left: 2),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  // ignore: missing_return
                  overscroll.disallowGlow();
                },
                child: FutureBuilder<QuerySnapshot>(
                  future: api.getProjectsFuture(),
                  builder: (BuildContext context, snapshot){
                    if (snapshot.hasError)
                      customF.errorWidget(snapshot.error.toString());
                    return snapshot.hasData ?
                    projectUI(snapshot.data) : customF.loadingWidget();

                  },
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

projectUI(QuerySnapshot snapshot){
  print(snapshot.documents[0].data);
  return ListView.separated(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.only(bottom: 10),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: (snapshot.documents.length == null ? 0 : snapshot.documents.length),
    itemBuilder: (context, index) {
      return Container(
        //https://gist.github.com/haidar786/eb2d39251b21ed8249abee06641452c6
        child:  (snapshot.documents.length > 0 ? Container(
            child: GestureDetector(
              child: ListTile(
                dense: true,
                trailing: Column(
                  children: <Widget>[
                    checkIcon(snapshot.documents[index].data['status']),
                    Text(checkString(snapshot.documents[index].data['status']))
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
                          FontAwesomeIcons.solidFile,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: <Widget>[
                    Text(
                      snapshot.documents[index].data['Title'] == null ? '' : snapshot.documents[index].data['Title'],
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
                      Text(snapshot.documents[index].data['DateCreated'] == null ? ''
                          : snapshot.documents[index].data['DateCreated'],
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
              ),
              onTap: (){
                customF.detailsDialog(title:snapshot.documents[index].data['Title'],
                    status: snapshot.documents[index].data['status'],
                    supervisors: snapshot.documents[index].data['supervisor'],
                context: context);
              },
            )
        )
            : getInformationMessage('No Latest Transaction')),
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
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
        return  'Complete';
        break;

      default:
        return '';
    }
  }

  Widget getStatusWidget (bool status){
    if(status){ //If status is true
      return Icon(
        Icons.check,
        size: 22.0,
        color: Colors.green,
      );

    }else if(!status){ //If status is false
      return Icon(
        Icons.error_outline,
        size: 22.0,
        color: Colors.redAccent,
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
