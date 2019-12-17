//
import 'package:flutter/material.dart';
import 'package:virtualworkng/TesterUI.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminMainScreen.dart';
import 'package:virtualworkng/screens/Countdown.dart';
import 'package:virtualworkng/screens/LoginScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffMainScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/screens/Wrapper.dart';
import 'package:virtualworkng/ui/StaffRegisteration.dart';
import 'package:virtualworkng/ui/AdminRegisterPage.dart';

////sending dat to next screen
////Navigator.pushNamed(context, feedRoute, arguments: 'Data from home');
////var data = settings.arguments as String;
////return MaterialPageRoute(builder: (_) => Feed(data));
//import 'package:flutter/material.dart';
////import 'package:smartchurch/enum/constants.dart';
////import 'package:booking_theater/ui/dashboardView.dart';
////import 'package:smartchurch/ui/login_Register_View.dart';
//
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
//      case onscreenRoute:
//        return MaterialPageRoute(builder: (_) => OnscreenView());

     case mainRoute:
       return MaterialPageRoute(builder: (_) => Wrapper());

//      case adminLoginRegisterRoute:  ///ADMIN DOESN"T REGISTER ON THE APP ANYMORE
//        return MaterialPageRoute(builder: (_) => AdminRegisterPage());

     case loginRoute:
       return MaterialPageRoute(builder: (_) => LoginScreen());

         case adminDashboardRoute:
        return MaterialPageRoute(builder: (_) => AdminMainScreen());

        case staffDashboardRoute:
       return MaterialPageRoute(builder: (_) => StaffMainScreen()); //StaffMainScreen()

      case staffRegister:
        return MaterialPageRoute(builder: (_) => AdminRegisterPage());

       case TestingRoute:
       return MaterialPageRoute(builder: (_) => LoginScreen());

      case countdownRoute:
        return MaterialPageRoute(builder: (_) => CountDownTimer());

        case submitReportRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SubmitReportUI());
    }
  }
}
