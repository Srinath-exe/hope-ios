import 'package:flutter/material.dart';
import 'package:hopepoints/Model/Login_model.dart';
import 'package:hopepoints/Model/postvalidateOtp.dart';
import 'package:hopepoints/Screens/NewPassowrd.dart';
import 'package:hopepoints/Screens/homePage.dart';
import 'package:hopepoints/Screens/referral.dart';
import 'package:hopepoints/services/apiService.dart';

import 'package:otp_screen/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificatioPage extends StatefulWidget {
  String otp;
  String userid;
  String mobile;
  String password;
  String type;
  VerificatioPage(
      {this.otp, this.type, this.mobile, this.userid, this.password});
  @override
  _VerificatioPageState createState() => _VerificatioPageState();
}

class _VerificatioPageState extends State<VerificatioPage> {
  PostValidateOtp postValidateOtp = new PostValidateOtp();
  ApiService apiService;
  PostLogin postLogin;
  @override
  void initState() {
    apiService = new ApiService();
    postLogin = new PostLogin(
      email: widget.mobile,
      pass: widget.password,
    );
    postValidateOtp = PostValidateOtp(
        otpMobile: widget.mobile, otpUserid: widget.userid, otpOtp: widget.otp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OtpScreen(
      otpLength: 6,
      icon: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/otplogo.png'),
                fit: BoxFit.contain)),
      ),
      validateOtp: validateOtp,
      routeCallback: moveToNextScreen,
      title: "Verification",
      subTitle: "Enter the code sent to your number",
      titleColor: Colors.black,
      themeColor: Color(0xffE58714),
    );
  }

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (otp == widget.otp) {
      apiService.validateOtp(postValidateOtp).then((value) {
        if (value!=null) {
              return null;
        } else {
          return "OTP does not Match";
        }
      });
      return null;
    } else {
      return "OTP does not Match";
    }
  }

  void moveToNextScreen(context) {
    if (widget.type == 'signup') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewPassword()));
    }
  }
}
