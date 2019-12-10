import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/core/Services/Authenticate/authentication.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/UserModel.dart';
import 'package:virtualworkng/router.dart';
import 'package:virtualworkng/screens/MenuScreen.dart';
import 'package:virtualworkng/style/AppText.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//   DevicePreview(
//     builder: (context) => MyApp(route: TestingRoute,),
//   ),
//   );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String admin = prefs.getString(AdminMail);
  String staff = prefs.getString(StaffEmail);
  setupLocator();


  if(admin != null){
    runApp(MyApp(route: TestingRoute,));
    //runApp(MyApp(route: adminDashboardRoute,));

  }else if(staff != null){
    runApp(MyApp(route: TestingRoute,));

  }else{
    runApp(MyApp(route: TestingRoute,));
  }

}

class MyApp extends StatelessWidget {
  var authentication = locator<AuthService>();

  //The first Page to load when launch
  String route;
  MyApp({ @required this.route});
  @override
  Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       locale: DevicePreview.of(context).locale, // <--- Add the locale
//       builder: DevicePreview.appBuilder, // <--- Add the builder
//       title: AppText.appName,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     onGenerateRoute: Router.generateRoute,
//       initialRoute:route,
//     );
     return StreamProvider<User>.value(
           value: authentication.isUserLoggedIn, //Realtime checking if User LogIn or not
            child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppText.appName,
            theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute:route,
    ),
     );


  }
}

