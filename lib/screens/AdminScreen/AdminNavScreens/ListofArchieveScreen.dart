import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/staffDetailsClicked.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/SearchScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/ListofArchieveWidgets.dart';
import 'package:virtualworkng/widgets/ListofStaffWidgets.dart';
import 'package:virtualworkng/widgets/StaffDetailsWidgets.dart';

var api = locator<Api>();
var customF = locator<CustomFunction>();

class ListofArchieveScreen extends StatefulWidget {
  @override
  _ListofArchieveScreenState createState() => _ListofArchieveScreenState();
}

class _ListofArchieveScreenState extends State<ListofArchieveScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.nearlyWhite,
      body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              builder: (context) => StaffDetailsClicked(),
              child: Container(),
            ),
          ],
        child: StreamBuilder<QuerySnapshot>(
            stream: api.getListOfArchieve(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                customF.errorWidget(snapshot.error.toString());
              return snapshot.hasData
                  ? ListofArchieveWidgets(snapshot.data.documents):
              customF.loadingWidget();
            }
      ),
      ),

    );
  }


}