import 'package:flutter/material.dart';

class RoundedRecButton extends StatelessWidget {
  final String title;
  final List<Color> gradientColor;

RoundedRecButton({this.title, this.gradientColor});

  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors:gradientColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(this.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
        ],
      ),
    );
  }
}