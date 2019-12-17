import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListofArchieveScreen.dart';
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
  List<String> withdrawalList = new List<String>();
  String _selectedW;
  String _selectedBankNameid;
  TextEditingController emailController, fNameController, lNameController,
      phoneNController,acctNameController, acctNumberController ;
  bool processing = false;
  String mail;

  @override
  void initState() {
    super.initState();
    getEmail();
    emailController = new TextEditingController();
    fNameController = new TextEditingController();
    lNameController = new TextEditingController();
    phoneNController = new TextEditingController();
    acctNameController = new TextEditingController();
    acctNumberController = new TextEditingController();
    getBankData();
    loadPlan();
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: api.myDetails(mail),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError)
            customF.errorWidget(snapshot.error.toString());
          return snapshot.hasData
              ?  SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  storeInController(snapshot.data),
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
                                        image:  (snapshot.data.data['Picture'] == null ? ExactAssetImage(
                                            'assets/images/img/admin.png') :
                                        NetworkImage(
                                          snapshot.data.data['Picture'],
                                        )),
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
                            keyboardType: TextInputType.text,
                            controller: fNameController,
                            enabled: !_status,
                            autofocus: !_status,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'First Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: lNameController,
                            enabled: !_status,
                            autofocus: !_status,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Last Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Email',
                              enabled: false,
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                            controller: emailController,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            enabled: !_status,
                            autofocus: !_status,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Phone Number',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                            controller: phoneNController,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 6.0),
                            child: FindDropdown(
                              items: getBanklistDisplay,
                              label: "Choose Bank",
                              onChanged:(value){
                                if(snapshot.data.data['BankName'] != null){
                                  snapshot.data.data['BankName'] = value;
                                }
                                _selectedBankNameid = value;
                              },
                              selectedItem: (snapshot.data.data['BankName'] != null ? snapshot.data.data['BankName'].toString()
                              : 'Access Bank'),
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
                            controller: acctNameController,
                            enabled: !_status,
                            autofocus: !_status,
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
                            controller: acctNumberController,
                            enabled: !_status,
                            autofocus: !_status,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Account Number',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0,  right: 25.0),
                              child: Container(
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
                                  items: withdrawalList.map((String val) {
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
                              ),
                              ),
                          !_status ? (processing ? customF.loadingWidget() : _getActionButtons()) : new Container(),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ) :
          customF.loadingWidget();
        }
      )
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
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
                      updateDetails();
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

  getEmail()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString(StaffEmail);
    });

  }

  loadPlan(){
    withdrawalList.add("Bi-monthly");
    withdrawalList.add("monthly");
  }

  storeInController(DocumentSnapshot data){
    emailController.text = data.data['Email'];
    fNameController.text = data.data['Firstname'];
    lNameController.text =  data.data['Lastname'];
    phoneNController.text =  data.data['PhoneNumber'];
    acctNameController.text =  data.data['AccountName'];
    acctNumberController.text =  data.data['AccountNumber'];
    _selectedBankNameid = data.data['BankName'];
    _selectedW = data.data['WithdrawalPlan'];
        return Container();
  }

  updateDetails()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(StaffEmail);
    String fname = fNameController.text.trim();
    String lname = lNameController.text.trim();
    String phone = phoneNController.text.trim();
    String accountname = acctNameController.text.trim();
    String accountN = acctNumberController.text.trim();
    String bankN = _selectedBankNameid;
    String withdrawal = _selectedW;

    if(fname.isEmpty || lname.isEmpty || phone.isEmpty || accountname.isEmpty
        || accountN.isEmpty || bankN.isEmpty || withdrawal.isEmpty) {
      customF.showToast(message: 'Empty field detected');

    }else if(phone.trim().length < 11 || phone.trim().length > 11) {
      customF.showToast(
          message: 'Your PhoneNumber must be 11 numbers in length');

//    }else if(imageFile.getImageFile == null){
//      customF.showToast(message: 'No image selected');
//    }
    }else{
      startLoading();
      api.updateMoreDetailsToStaff(fName: fname, staffEmail: email,
          lName: lname, phone: phone,
          accountN: accountname, accountNo: accountN, bankName: bankN, withdrawalPlan: withdrawal).then((v){
        startLoading();
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Data Successfully Update');

        }
      });
    }
  }

  startLoading(){
    setState(() {
      processing = true;
    });
  }

  stopLoading(){
    setState(() {
      processing = false;
    });
  }
}
