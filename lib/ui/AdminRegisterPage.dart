import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virtualworkng/model/uploadImageModel.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/ui/StaffRegisteration.dart';
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
  File _image;

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
    return ChangeNotifierProvider(
      builder: (context) => UploadImageModel(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UploadImageModel>(builder:
            (context, imageModel, _) =>
                Scaffold(
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
                              padding: EdgeInsets.only(top: 70.0),
                              child: Container(
                                height: 160.0,
                                child: new Column(
                                  children: <Widget>[
                                    Stack(fit: StackFit.loose, children: <Widget>[
                                      new Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            width: 140.0,
                                            height: 140.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image:  DecorationImage(
                                                image: ExactAssetImage('assets/images/img/as.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child:  _image == null
                                                ? Container()
                                                : CircleAvatar(backgroundImage: new FileImage(_image), radius: 200.0,),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                child: new CircleAvatar(
                                                  backgroundColor: AppColor.thirdColor,
                                                  radius: 25.0,
                                                  child: new Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onTap: (){
                                                  getImage(imageModel);
                                                },
                                              )
                                            ],
                                          )),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
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
                                    child: StaffRegisteration(),
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

  Future getImage(UploadImageModel imageModel) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      imageModel.setImageFile = _image; //Setting image, so that the Widget attached to this Page can use it.
    });
  }
}
