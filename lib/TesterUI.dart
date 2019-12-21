import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/noInternet.dart';

var customF = locator<CustomFunction>();
var api = locator<Api>();

class TesterUI extends StatefulWidget {
  @override
  _TesterUIState createState() => _TesterUIState();
}

class _TesterUIState extends State<TesterUI> {
  bool processing = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context, ConnectivityResult connectivity,
                Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              return  Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                      child: (connected ? body() : NoInternetWidgets())
                  ),
                ],
              );
            },
            child: Container()
        ));
  }
  body(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Tester'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.orange,
              child: Text('Click me'),
              onPressed: () {
                todo();
              },
            ),
            (processing ? CircularProgressIndicator() : Container()),
          ],
        ),
      ),
    );
  }

  todo() {
    startLoading();
   api.sendFunds();

  }

  startLoading() {
    setState(() {
      processing = true;
    });
  }

  stopLoading() {
    setState(() {
      processing = false;
    });
  }

}
