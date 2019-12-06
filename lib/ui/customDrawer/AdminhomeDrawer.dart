import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class AdminHomeDrawer extends StatefulWidget {
  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;
  AdminHomeDrawer(
      {Key key, this.screenIndex, this.iconAnimationController, this.callBackIndex})
      : super(key: key);

  @override
  _AdminHomeDrawerState createState() => _AdminHomeDrawerState();
}

class _AdminHomeDrawerState extends State<AdminHomeDrawer> {
  List<DrawerList> drawerList;
  @override
  void initState() {
    setdDrawerListArray();
    super.initState();
  }

  void setdDrawerListArray() {
    drawerList = [
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: new Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Users,
        labelName: 'Staff',
        isAssetsImage: false,
        // imageName: "assets/images/img/supportIcon.png",
        icon: Icon(FontAwesomeIcons.user, color: Colors.orange,)
      ),
      DrawerList(
        index: DrawerIndex.Disputes,
        labelName: 'Disputes',
        icon: new Icon(FontAwesomeIcons.laugh),
      ),
      DrawerList(
        index: DrawerIndex.Withdrawals,
        labelName: 'Withdrawals',
        icon: new Icon(Icons.account_balance_wallet),
      ),
      DrawerList(
        index: DrawerIndex.Reports,
        labelName: 'Reports',
        icon: new Icon(CommunityMaterialIcons.reply),
      ),
//      DrawerList(
//        index: DrawerIndex.About,
//        labelName: 'About Us',
//        icon: new Icon(Icons.info),
//      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 40.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return new ScaleTransition(
                        scale: new AlwaysStoppedAnimation(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(Tween(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColor.grey.withOpacity(0.6),
                                    offset: Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset("assets/images/img/admin.png"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      "Miss Aderonke",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColor.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppColor.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppColor.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: new Text(
                  "Sign Out",
                  style: AppTextStyle.headerSmall(context),
                  textAlign: TextAlign.left,
                ),
                trailing: new Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          print('Am navigating');
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                     decoration: BoxDecoration(
                       color: widget.screenIndex == listData.index
                           ? AppColor.primaryColorDark
                           : Colors.transparent,
                       borderRadius: new BorderRadius.only(
                         topLeft: Radius.circular(0),
                         topRight: Radius.circular(16),
                         bottomLeft: Radius.circular(0),
                         bottomRight: Radius.circular(16),
                       ),
                     ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? AppColor.primaryColorDark
                                  : AppColor.nearlyBlack),
                        )
                      : new Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? AppColor.primaryColorDark
                              : AppColor.nearlyBlack),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  new Text(
                    listData.labelName,
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? AppColor.primaryColorDark
                          : AppColor.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return new Transform(
                        transform: new Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColorDark.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  void navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  Users,
  Disputes,
  Withdrawals,
  Reports,
}

class DrawerList {
  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;

  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });
}
