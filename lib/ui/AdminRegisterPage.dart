import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/ui/AdminRegister1.dart';
import 'package:virtualworkng/ui/RegisterCompany.dart';
import 'package:virtualworkng/util/bubble_indication_painter.dart';

class AdminRegisterPage extends StatefulWidget {
  @override
  _AdminRegisterPageState createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height >= 775.0 ? MediaQuery.of(context).size.height : 840.0,
            height: MediaQuery.of(context).size.height >= 605.0 ? MediaQuery.of(context).size.height : 100.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.secondColor,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 74.0),
                  child: new Image(
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/images/newlogo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                       ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: AdminRegister1(),
                      ),
//                       ConstrainedBox(
//                        constraints: const BoxConstraints.expand(),
//                        child: RegisterCompany(),
//                      ),
//                      ConstrainedBox(
//                        constraints: const BoxConstraints.expand(),
//                        child: AdminRegister1(),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 150.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Your Details",
                  style: TextStyle(
                      color: left,
                      fontSize: 12.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
//            Expanded(
//              child: FlatButton(
//                splashColor: Colors.transparent,
//                highlightColor: Colors.transparent,
//                onPressed: _onSignUpButtonPress,
//                child: Text(
//                  "Company details",
//                  style: TextStyle(
//                      color: right,
//                      fontSize: 12.0,
//                      fontFamily: "WorkSansSemiBold"),
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                splashColor: Colors.transparent,
//                highlightColor: Colors.transparent,
//                onPressed: _onther,
//                child: Text(
//                  "Next Phase",
//                  style: TextStyle(
//                      color: right,
//                      fontSize: 12.0,
//                      fontFamily: "WorkSansSemiBold"),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void _onther() {
    _pageController?.animateToPage(3,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }
}
