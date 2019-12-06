import 'package:flutter/material.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class NoInternetWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColor.noInternet,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/flare/men_wearing_jacket.gif',
              fit: BoxFit.cover,
            ),
            Text('No Internet Connection',
              style: AppTextStyle.error(context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Please turn on your Internet',
                style: AppTextStyle.help(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
