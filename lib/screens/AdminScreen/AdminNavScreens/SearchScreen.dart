import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/SearchService.dart';
import 'package:virtualworkng/widgets/ListofStaffWidgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var temperatureSearchStore = [];
  QuerySnapshot dataDoc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10.0,
        title:  TextField(
          onChanged: (val){
            initialSearch(value: val);
          },
          decoration: InputDecoration(
            prefixIcon: IconButton(
              color: Colors.orange,
              icon: Icon(Icons.search),
              iconSize: 30.0,
              onPressed: (){
                gt();
                // Navigator.pop(context)  ;
              },),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: AppColor.primaryColor,
              ),
              onPressed: () => print('Clear'),
            ),
            border: InputBorder.none,
            hintText: 'Search by name',
          ),
        ),
      ),
      body: (dataDoc == null ? SizedBox(): ListView.builder(
          itemCount: dataDoc.documents.length == null ? 0 : dataDoc.documents.length,
          itemBuilder: (BuildContext context, index){
            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      AvatarGlow(
                        startDelay: Duration(milliseconds: 1000),
                        glowColor: AppColor.thirdColor,
                        endRadius: 30.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: CircleAvatar(
                          backgroundColor:Colors.orange ,
                          child: Image.asset('assets/images/img/userimage.jpg',height: 60, fit: BoxFit.cover,),
                          radius: 20.0,
                        ),
                        shape: BoxShape.circle,
                        animate: true,
                        curve: Curves.fastOutSlowIn,
                      ),
                      Text('Email: ${dataDoc.documents[index].data['Email'].toString()}',
                        style: AppTextStyle.editTextSmall(context),),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Privilege: ${dataDoc.documents[index].data['privilege'].toString()}',
                            style: AppTextStyle.snackbar(context),),
                          GestureDetector(child: Icon(FontAwesomeIcons.edit), onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
//                                  return UpdateStaffDetails(previlege: documents[index].data['privilege'].toString(),
//                                    Email: documents[index].data['Email'],);
                                });
                          },)
                        ],
                      ),
                    )
                  ],
                )
            );
          }))
    );
  }

  initialSearch({String value}){
    if(value.length == 0){
     setState(() {
       queryResultSet = [];
       temperatureSearchStore = [];
     });
    }
    var capitalizedValue = value.substring(0,1).toUpperCase() + value.substring(1);

    if(queryResultSet.length == 0 && value.length == 1){
        SearchServices().searchByName(searchfield: value).then((QuerySnapshot doc){
          setState(() {
            dataDoc = doc;
          });
          for(int i = 0; i < doc.documents.length; ++i){
            //print(doc.documents[i].data);
            queryResultSet.add(doc.documents[i].data);
          }
        });
    }else{
      temperatureSearchStore = [];
      queryResultSet.forEach((v){
        if(v['Email'].startsWith(capitalizedValue)){
          setState(() {
            temperatureSearchStore.add(v);
          });
        }
      });
    }
  }

  gt(){
    print('GET.........');
    for(int i = 0; i < temperatureSearchStore.length; ++i){
      print(temperatureSearchStore[i]);
    }
  }

}
