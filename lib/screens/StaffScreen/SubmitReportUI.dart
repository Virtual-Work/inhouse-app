import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

var customF = locator<CustomFunction>();
var api = locator<Api>();
//******************************************************************************************************************
//*******************SubmitReportUI**********************************
///**********************************************************************************************************************
class SubmitReportUI extends StatefulWidget {
  final String projectSelected;

  const SubmitReportUI({this.projectSelected});

  @override
  _SubmitReportUIState createState() => _SubmitReportUIState();
}

class _SubmitReportUIState extends State<SubmitReportUI> {
  bool processing = false;
  String fromDate, toDate;
  TextEditingController projectController = TextEditingController();

  int _quantity = 1;
  List _listofTaskUI = List();
  List<TextEditingController> controller;
  Map<String, String> inputMap = new Map(); //taskName,(key) while hours(value)
  bool isReportPeriodSelected = false;
  var tempSearchStore = [];

  TextEditingController taskNameController = TextEditingController();
  Map<int, TextEditingController> map = new Map<int, TextEditingController>();
  TextEditingController hoursController = TextEditingController();
  final taskNameView = List<TextField>();
  final hoursView = List<TextField>();

  @override
  void initState() {
    super.initState();
    projectController.text = widget.projectSelected;
  }

  @override
  Widget build(BuildContext context) {

//    _listofTaskUI.forEach((str) {
//      var textEditingController = new TextEditingController(text: str.toString());
//      textEditingControllers.add(textEditingController);
//      return textFields.add(new TextField(controller: textEditingController));
//    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.thirdColor,
        title: Center(child: Text('Submit Report', style: AppTextStyle.headerSmall2(context),)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  enabled: false,
                  controller: projectController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Selected Project',
                    labelStyle: AppTextStyle.inputLabelStyle(context),
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Choose Report Period', style: AppTextStyle.headerSmaller(context),),
                        color: AppColor.teal,
                        onPressed: ()async{
                          final List<DateTime> picked = await DateRagePicker.showDatePicker(
                              context: context,
                              initialFirstDate: new DateTime.now(),
                              initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                              firstDate: new DateTime(2015),
                              lastDate: new DateTime(2020)
                          );
                          if (picked != null && picked.length == 2) {
                            setState(() {
                              fromDate = format(picked[0]);
                              toDate = format(picked[1]);
                              isReportPeriodSelected = true; //Allow other UI to show, so that i can enter tasks and submit
                            });
                          }
                        },
                      ),
                      Text(fromDate == null ? '' : 'From', style: AppTextStyle.headerSmall3(context),),
                      Text(fromDate == null ? '' : fromDate, style: AppTextStyle.h2(context),),
                      Text(toDate == null ? '' : 'To', style: AppTextStyle.headerSmall3(context),),
                      Text(toDate == null ? '' : toDate, style: AppTextStyle.h2(context),),
                    ],
                  )
              ),
              //Hide this UI if Report date has not been selected
             Visibility(
               child: Column(
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(top: 10, bottom: 15),
                     child: Column(
                       children: <Widget>[
                         Container(
                           child: Text('Task Number', style: AppTextStyle.error(context)),
                           margin: EdgeInsets.only(bottom: 15),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Container(
                               color: AppColor.thirdColor,
                               width: 50,
                               height: 50,
                               child: OutlineButton(
                                 onPressed: () {
                                   setState(() {
                                     _quantity += 1;
//                                   taskNameView.add(new TextField(controller: taskNameController));
//                                   hoursView.add(new TextField(controller: hoursController));
                                     _listofTaskUI.add(_quantity);
                                     tempSearchStore.add(new TextEditingController());
                                   });
                                 },
                                 child: Icon(Icons.add, color: Colors.white,),
                               ),
                             ),
                             Container(
                               margin: EdgeInsets.only(left: 20, right: 20),
                               child: Text(_quantity.toString(), style: AppTextStyle.h2(context)),
                             ),
                             Container(
                               color: AppColor.thirdColor,
                               width: 50,
                               height: 50,
                               child: OutlineButton(
                                 onPressed: () {
                                   setState(() {
                                     if(_quantity == 1) return;
                                     _quantity -= 1;
                                     _listofTaskUI.removeAt(_quantity);
//                                     taskNameView.removeAt(_quantity);
//                                     hoursView.removeAt(_quantity);
                                   });
                                 },
                                 child: Icon(Icons.remove, color: Colors.white,),
                               ),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                   Container(
                     child: Text('Tasks', style: AppTextStyle.error(context)),
                     margin: EdgeInsets.only(bottom: 1, top: 10),
                   ),
                   Column(
                     children: List.generate(_listofTaskUI.length,(index){
                      return taskUI(_listofTaskUI[index]);
                     }),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: TextField(
                       keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                         border: const UnderlineInputBorder(),
                         labelText: 'Total time used per week',
                         labelStyle: AppTextStyle.inputLabelStyle(context),
                         hintStyle: TextStyle(
                             fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                       ),
                     ),
                   ),
                   SizedBox(height: 20.0),
                   processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,)
                       : RaisedButton(
                     child: Text("Submit Report"),
                     splashColor: AppColor.orange,
                     elevation: 10,
                     animationDuration: Duration(seconds: 5),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20.0)
                     ),
                     color: AppColor.primaryColorDark,
                     textColor: Colors.white,
                     onPressed: (){
                     },
                   ),
                   SizedBox(height: 30.0),
                 ],
               ),
               visible: isReportPeriodSelected,
             ),
            ],
          ),
        ),
      ),
    );
  }

  taskUI(int index){
    return  Container(
      height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              child:  Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Task Name ',
                    labelStyle: AppTextStyle.inputLabelStyle(context),
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Container(
              width: 150,
              height: 150,
              child:  Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: hoursController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Hours',
                    labelStyle: AppTextStyle.inputLabelStyle(context),
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }

  showData(){
    var textFields = <TextField>[];
    var textEditingController = new TextEditingController();
    //textEditingControllers.add(textEditingController);
     textFields.add(new TextField(controller: textEditingController));
    return Text('');
  }

  submitReportApi(){
    if(fromDate.isEmpty && toDate.isEmpty){
      customF.showToast(message: 'Date required');
    }else{

    }
  }

  //Formatting Date
  format(var now){
    var formatter = new DateFormat('EEEE, MMMM dd, yyyy.');
    String formatted = formatter.format(now);
   return formatted;
  }
}