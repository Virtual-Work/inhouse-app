import 'package:flutter/material.dart';

class StaffDisputeScreen extends StatefulWidget {
  AnimationController animationController;

  StaffDisputeScreen(this.animationController);
  @override
  _StaffDisputeScreenState createState() => _StaffDisputeScreenState();
}

class _StaffDisputeScreenState extends State<StaffDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispute'),
      ),
    );
  }
}
