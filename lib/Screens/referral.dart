import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:hopepoints/Model/register_model.dart';
import 'package:hopepoints/Screens/homePage.dart';
import 'package:hopepoints/Screens/verificationPage.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:hopepoints/widgets/progressHUD.dart';

import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Referral extends StatefulWidget {
  PostRegister registermodel;
  Referral({this.registermodel});
  @override
  _ReferralState createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  ScrollController _controller;
  ApiService apiService;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = new ApiService();
    apiService = new ApiService();
    _controller = ScrollController(initialScrollOffset: 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('sinreferralgup  body: ${postRegisterToJson(widget.registermodel)}');
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.4,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/referral.png',
                                ),
                                fit: BoxFit.contain))),
                  )),
              Container(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Got a referral code?',
                    textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ),
                Text('Enter your referral code ',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                Text('and get upto 500 points',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        widget.registermodel.admRefferedBy = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 20, left: 20),
                      filled: true,
                      fillColor: Colors.grey[50],
                      focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[500], width: 2),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          )),
                      hintText: 'Enter your Referral Code',
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '-OR-',
                          textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        widget.registermodel.admCoupon = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 20, left: 20),
                      filled: true,
                      fillColor: Colors.grey[50],
                      focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[500], width: 2),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          )),
                      hintText: 'Enter your Coupon Code',
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(color: Colors.orange))),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.orange[200];
                              return Colors.white;
                            },
                          ),
                        ),
                        onPressed: () {
                          //On skip Pressed
                          setState(() {
                            isApiCallProcess = true;
                          });
                          widget.registermodel.admRefferedBy = '';
                          widget.registermodel.admCoupon = '';
                          apiService
                              .signUp(widget.registermodel)
                              .then((value) async {
                               print(value);
                            if (value == null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'SignUp failed',
                                  desc:
                                      'Account already exists with this Number',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                                setState(() {
                                  isApiCallProcess = false;
                                });
                              
                            } else {
                              if (value.error == false) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString('logged', 'true');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerificatioPage(
                                              password: widget
                                                  .registermodel.admSecret,
                                              userid: value.uuid,
                                              mobile: widget
                                                  .registermodel.admMobile,
                                              type: 'signup',
                                              otp: value.otp.toString(),
                                            )));
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'SignUp failed',
                                  desc:
                                      'Account already exists with this Number',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                setState(() {
                                  isApiCallProcess = false;
                                });
                              }
                            }
                          });
                        },
                        child: Text(
                          'Skip',
                            textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // Redeem Button
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(color: Colors.orange))),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.orange[200];
                              return Colors.orange;
                            },
                          ),
                        ),
                        onPressed: () {
                          // On Redeem Pressed
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiService
                              .signUp(widget.registermodel)
                              .then((value) async {
                            print(value);
                            if (value == null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'SignUp failed',
                                  desc:
                                      'Account already exists with this Number',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                                setState(() {
                                  isApiCallProcess = false;
                                });
                              
                            } else {
                              if (value.error == false) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString('logged', 'true');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerificatioPage(
                                              password: widget
                                                  .registermodel.admSecret,
                                              userid: value.uuid,
                                              mobile: widget
                                                  .registermodel.admMobile,
                                              type: 'signup',
                                              otp: value.otp.toString(),
                                            )));
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'SignUp failed',
                                  desc:
                                      'Account already exists with this Number',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                setState(() {
                                  isApiCallProcess = false;
                                });
                              }
                            }
                          });
                        },
                        child: Text(
                          'Redeem',
                            textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text('Invite your friends and get',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                Text('bonus points!',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                Text('Welcome to Hope,invite your friends  ',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                Text('with your code and get exciting bonus points',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                SizedBox(height: 30),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.5,
                //   height: MediaQuery.of(context).size.height * 0.05,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20.0),
                //               side: BorderSide(color: Colors.orange))),
                //       backgroundColor: MaterialStateProperty.resolveWith<Color>(
                //         (Set<MaterialState> states) {
                //           if (states.contains(MaterialState.pressed))
                //             return Colors.orange[200];
                //           return Colors.white;
                //         },
                //       ),
                //     ),
                //     onPressed: () {
                //       Share.share('http://www.hopeholding.co.tz/');
                //     },
                //     child: Text(
                //       'Invite',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.orange,
                //       ),
                //     ),
                //   ),
                // ),
              ]))
            ]),
          ),
        ));
  }
}
