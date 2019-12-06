import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppFontSizes.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:find_dropdown/find_dropdown.dart';

class StaffProfileScreen extends StatefulWidget {
  @override
  _StaffProfileScreenState createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> with TickerProviderStateMixin{
  bool _status = true;
  List<String> getBanklistDisplay = new List<String>();
  final FocusNode myFocusNode = FocusNode();
  List<String> withdrawlList = new List<String>();
  String _selectedW;
  String _selectedBankNameid;
  final TextEditingController NameController = new TextEditingController();

  final TextEditingController EmailController = new TextEditingController();
  final TextEditingController UserIDcontroller = new TextEditingController();

  final TextEditingController RefercodeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    loadW();
    getBankData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColorDark,
        title: Center(child: Text('Olajire Abdullah', style: TextStyle(
            fontFamily: "Metropolis",
            fontFamilyFallback: ["RobotoRegular"],
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.w400,
            color: AppColor.white))),
        leading: Text(''),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              highlightColor: Colors.yellowAccent,
              borderRadius:
              BorderRadius.all(Radius.circular(32.0)),
              child: Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.white,
                child:  Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 1.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image:  DecorationImage(
                                    image:  ExactAssetImage(
                                        'assets/images/img/admin.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: AppColor.primaryColorDark,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 9.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('Personal Information',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _status ? _getEditIcon() : new Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColor.primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0, left: 15, right: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Email',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),

                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Phone Number',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 6.0),
                        child: FindDropdown(
                          items: getBanklistDisplay,
                          label: "Choose Bank",
                          onChanged:(value){
                            _selectedBankNameid = value;
                          },
                          selectedItem: 'Access Bank',
                          validate: (String item) {
                            if (item == null)
                              return "Required field";
                            else if (item == "Access Bank")
                              return "Invalid item";
                            else
                              return null;
                          },
                        ),
                      ),//BANK
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Account Name',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),

                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Account Number',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Withdrawal Plan',
                          labelStyle: AppTextStyle.inputLabelStyle(context),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                        ),
                      ),
                     Padding(
                           padding: EdgeInsets.only(
                               top: 10.0, bottom: 20.0,  right: 25.0),
                           child: Row(children: <Widget>[
//                             Icon(FontAwesomeIcons.wallet, color: Colors.orange,),
//                             SizedBox(width: 15.0,),
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
                               "Withdrawal Plan",
                               textAlign: TextAlign.center,
                             ),
                             value: _selectedW,
                             onChanged: (String value) {
                               setState(() {
                                 _selectedW = value;
                               });
                               print(_selectedW);
                             },
                             items: withdrawlList.map((String val) {
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
                      !_status ? _getActionButtons() : new Container(),
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: AppColor.primaryColorDark,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  getBankData() {
    getBanklistDisplay.add('Access Bank');
    getBanklistDisplay.add('Citibank');
    getBanklistDisplay.add('Coronation Merchant Bank');
    getBanklistDisplay.add('Diamond Bank');
    getBanklistDisplay.add('Ecobank');
    getBanklistDisplay.add('Enterprise Bank');
    getBanklistDisplay.add('First Bank');
    getBanklistDisplay.add('FBN Holdings PLC');
    getBanklistDisplay.add('FBN Merchant Bank');
    getBanklistDisplay.add('FCMB Group PLC');
    getBanklistDisplay.add('First City Monument Bank');
    getBanklistDisplay.add('FSDH Merchant Bank');
    getBanklistDisplay.add('Guaranty Trust Bank');
    getBanklistDisplay.add('Heritage Bank');
    getBanklistDisplay.add('Jaiz Bank');
    getBanklistDisplay.add('Providus Bank');
    getBanklistDisplay.add('Rand Merchant Bank');
    getBanklistDisplay.add('Sterling Bank');
    getBanklistDisplay.add('Stanbic IBTC Bank');
    getBanklistDisplay.add('Stanbic IBTC Holdings PLC');
    getBanklistDisplay.add('Skye Bank');
    getBanklistDisplay.add('Standard Chartered Bank');
    getBanklistDisplay.add('Suntrust Bank');
    getBanklistDisplay.add('United Bank For Africa');
    getBanklistDisplay.add('Unity Bank');
    getBanklistDisplay.add('Union Bank');
    getBanklistDisplay.add('Wema Bank');
    getBanklistDisplay.add('Zenith Bank');
  }

  loadW(){
    withdrawlList.add("Bi-monthly");
    withdrawlList.add("monthly");
  }
}
