import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:virtualworkng/style/AppColor.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final AnimationController animationController;
  final Animation animation;

  const TitleView(
      {Key key,
        this.titleTxt: "",
        this.animationController,
        this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppColor.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: 0.1,
                          color: AppColor.thirdColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

