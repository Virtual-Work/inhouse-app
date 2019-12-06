import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final bool isPasswordUI;
  final TextEditingController emailController;

  InputWidget(this.topRight, this.bottomRight, this.isPasswordUI, this.emailController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        child: Material(
          elevation: 15,
          shadowColor: AppColor.accents,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
            //Checking if isPasswordUI is true return Password TextField else return normal textfiedl
            child: (isPasswordUI 
            ? TextField(
               obscureText: true,
              style: AppTextStyle.editTextSmall(context),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "*******",
                  hintStyle: AppTextStyle.inputHint(context),
                  suffixIcon: GestureDetector(child: Icon(
                    FontAwesomeIcons.eye,
                    color: AppColor.deep,
                  ),)
              ),
              
            ) 
            : 
            TextField(
              controller: emailController,
              style: AppTextStyle.editTextSmall(context),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "me@virtualwork.ng",
                  hintStyle: AppTextStyle.inputHint(context),
              ),
            ))
          ),
        ),
      ),
    );
  }
}