import 'package:flutter/material.dart';
import 'package:virtualworkng/screens/LoginScreen.dart';
import 'dart:math' as math;

import 'package:virtualworkng/style/AppColor.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, duration: Duration(minutes: 5),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
//    controller.addStatusListener((status) {
//      if(status == AnimationStatus.reverse) {
//
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  Container(
                    color: Colors.amber,
                    height:
                    controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                        animation: controller,
                                        backgroundColor: Colors.white,
                                        color: AppColor.thirdColor,
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Please wait....",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            if(controller.isAnimating){
                              return SizedBox();
                            }else{
                              return FloatingActionButton.extended(
                                  backgroundColor:AppColor.thirdColor,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                        builder: (context) => LoginScreen()
                                    ),
                                    );
//                                  if (controller.isAnimating)
//                                    controller.stop();
//                                  else {
//                                    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
//                                  }
                                  },
                                  icon:  (controller.isAnimating ? Icon(Icons.account_circle,
                                    color: AppColor.thirdColor,)  :
                                  Icon(Icons.account_circle)),
                                  label: Text(controller.isAnimating ? "" : "Login")
                              );
                            }

                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }


}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
