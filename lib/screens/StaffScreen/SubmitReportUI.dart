import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SubmitReportUI extends StatefulWidget {
  @override
  _SubmitReportUIState createState() => _SubmitReportUIState();
}

class _SubmitReportUIState extends State<SubmitReportUI> {

  List<String> _projects = new List<String>();
  String _selectedProject;
  bool processing = false;
  String fromDate, toDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: AppColor.primaryColorDark,
              child: Center(child: Text('Add Report', style: AppTextStyle.headerSmall2(context),)),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  Text('Report Period'),
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                              showTitleActions: true,
//                              minTime: DateTime(2018, 3, 5),
//                              maxTime: DateTime(2019, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  fromDate = date.toString();
                                });
                                print('change $date');
                              }, onConfirm: (date) {
                              setState(() {
                                fromDate = date.toString();
                              });

                              }, currentTime: DateTime.now(),);
                          },
                          child: Text(
                            'From', style: TextStyle(color: Colors.blue),
                          )),
                      Text(fromDate == null ? '' : fromDate),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                              showTitleActions: true,

//                              minTime: DateTime(2018, 3, 5),
//                              maxTime: DateTime(2019, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  toDate = date.toString();
                                });
                                print('change $date');
                              }, onConfirm: (date) {
                              setState(() {
                                toDate = date.toString();
                              });

                              }, currentTime: DateTime.now(),);
                          },
                          child: Text(
                            'To', style: TextStyle(color: Colors.blue),
                          )),
                      Text(fromDate == null ? '' : fromDate),
                    ],
                  ),

                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: FindDropdown(
                items: _projects,
                label: "Select Project",
                onChanged:(value){
                  _selectedProject = value;
                },
                selectedItem: 'Adobe',
                validate: (String item) {
                  if (item == null)
                    return "Required field";
                  else if (item == "Adobe")
                    return "Invalid item";
                  else
                    return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Total Time',
                  labelStyle: AppTextStyle.inputLabelStyle(context),
                  hintStyle: TextStyle(
                      fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Short Description',
                  labelStyle: AppTextStyle.inputLabelStyle(context),
                  hintStyle: TextStyle(
                      fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                ),

              ),
            ),
            SizedBox(height: 10.0),
            processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,) : RaisedButton(
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
      ),
    );
  }

  @override
  void initState() {
    add();
    super.initState();
  }
add(){
  _projects.add('Adobe');
  _projects.add('User Interface');
  _projects.add('Mobile Dev.');
}


}