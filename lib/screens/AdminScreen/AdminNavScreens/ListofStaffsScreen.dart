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
import 'package:virtualworkng/widgets/ListofStaffWidgets.dart';
import 'package:virtualworkng/widgets/StaffDetailsWidgets.dart';

var api = locator<Api>();
var customF = locator<CustomFunction>();

class ListofStaffScreen extends StatefulWidget {
  @override
  _ListofStaffScreenState createState() => _ListofStaffScreenState();
}

class _ListofStaffScreenState extends State<ListofStaffScreen> {

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
            stream: api.getListOfStaffs(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                customF.errorWidget(snapshot.error.toString());
              return snapshot.hasData
                  ? ListOfStaffWidgets(snapshot.data.documents):
              customF.loadingWidget();
            }
      ),
      ),
     floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.thirdColor,
        child: Icon(Icons.add, color: AppColor.white,
          size: 19,), onPressed: () {
        _addStaffUI(context);
      },
      ),
    );
  }


  _addStaffUI(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
            return AddStaff(stateSetter: state,);
          });
        });
  }


  Widget _floatingCollapsed(){
    // final clicked = Provider.of<QuerySnapshot>(context);

    // print(clicked.documents);
    return Container(
      decoration: BoxDecoration(
        color: AppColor.nearlyDarkBlue,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 70.0, 24.0, 0.0),
      child: Center(
        child: Text(
          "This is the collapsed Widget",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _floatingPanel(List<DocumentSnapshot> documents, int index){
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.all(54.0),
      child: Center(
          child: StaffDetailsWidgets(email: documents[index].data['Email'].toString(),
              firstName: documents[index].data['Firstname'].toString(),
              lastName: documents[index].data['Lastname'].toString(),
              //pix: documents[index].data['pic'].toString(),
              privilege: documents[index].data['privilege'].toString(),
              projects: documents[index].data['Projects']
          )
      ),
    );
  }
}

class AddStaff extends StatefulWidget {
 final StateSetter stateSetter;

 AddStaff({this.stateSetter});

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  List<String> _previdleg = new List<String>();
  String _selectedPrevidleg;
  bool processing = false;
  TextEditingController staffMailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: AppColor.primaryColorDark,
                child: Center(child: Text('Add Staff', style: AppTextStyle.headerSmall2(context),)),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mail, color: Colors.orange,),
                    SizedBox(width: 15.0,),
                    Container(
                      width: 250,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: staffMailController,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Staff Email',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
               Padding(
                   padding: EdgeInsets.only(
                       top: 10.0, bottom: 20.0, left: 20.0, right: 25.0),
                   child: Row(children: <Widget>[
                     Icon(FontAwesomeIcons.user, color: Colors.orange,),
                     SizedBox(width: 15.0,),
                     Container(
                       width: 250,
                       height: 50,
                       child: DropdownButton<String>(
                     elevation: 6,
                     style: TextStyle(
                       color: AppColor.primaryColor,
                       fontSize: 15.0,
                       fontWeight: FontWeight.w500,
                     ),
                     hint: Text(
                       "Privilege ",
                       textAlign: TextAlign.center,
                     ),
                     value: _selectedPrevidleg,
                     onChanged: (String value) {
                       setState(() {
                         _selectedPrevidleg = value;
                       });
                       print(_selectedPrevidleg);
                     },
                     items: _previdleg.map((String val) {
                       return DropdownMenuItem<String>(
                         value: val,
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Text(
                               val.toString(),
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Colors.orange,
                               ),
                             )
                           ],
                         ),
                       );
                     }).toList(),
                     isExpanded: true,
                   ),
                     )
                   ],)
                 ),
              SizedBox(height: 10.0),
              processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,) : RaisedButton(
                child: Text("Proceed"),
                splashColor: AppColor.orange,
                elevation: 10,
                animationDuration: Duration(seconds: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                color: AppColor.primaryColorDark,
                textColor: Colors.white,
                onPressed: (){
                  addStaffAPI(); //Adding staff mail to the Server.
                },
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    add();
    super.initState();
  }

  add(){
    _previdleg.add('Staff');
    _previdleg.add('supervisor');
  }

  addStaffAPI(){
    if(staffMailController.text.trim().isEmpty){
      customF.showToast(message: 'Invalid Staff Email');

    }else if(!customF.isVirtualWorkNGMail(mail: staffMailController.text)) {
      customF.showToast(message: 'Invalid Email');

    }else{
      startLoading();
      api.addStaff(staffEmail: staffMailController.text.trim(), priviledge: _selectedPrevidleg).then((v) {
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Successfully Registered');
          Navigator.pop(context);
        }
      });
    }
  }

  startLoading(){
    widget.stateSetter(() {
      processing = true;
    });
  }

  stopLoading(){
    widget.stateSetter(() {
      processing = false;
    });
  }


}

