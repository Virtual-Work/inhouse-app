import 'package:flutter/material.dart';

class HomeList {
  Widget navigateScreen;
  String imagePath;

  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  static List<HomeList> homeList = [
    HomeList(
      imagePath: "assets/hotel/hotel_booking.png",
      navigateScreen: Text(''),
    ),
    HomeList(
      imagePath: "assets/fitness_app/fitness_app.png",
      navigateScreen: Text(''),
    ),
    HomeList(
      imagePath: "assets/design_course/design_course.png",
      navigateScreen: Text(''),
    ),
  ];
}
