import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hopepoints/Model/ForgotPassword.dart';
import 'package:hopepoints/Screens/PassResetOtp.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:hopepoints/widgets/progressHUD.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  ScrollController _controller;

  String phoneno;
  final _formKey = GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'TZ',dialCode: "+255");
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'TZ';
  bool isApiCallProcess = false;
  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        controller: _controller,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 180,
                            top: 10,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 80,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orange[800],
                                      Colors.orange[500],
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -40,
                            bottom: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.10,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orange[100],
                                      Colors.orange[100],
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -20,
                            top: -120,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.08),
                                  Icon(Icons.lock_outline, size: 120)
                                ],
                              ),
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orange[400],
                                      Colors.orange[300],
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Column(children: [
                    //image
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.04),
                          Text("Reset password",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w600)),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                          Text("Forgot your password?", textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),

                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: Column(children: [
                          Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                                    Text("Enter your registered phone number", textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.02),

                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.08,
                                      child: InternationalPhoneNumberInput(

                                        onInputChanged: (PhoneNumber number) {
                                          setState(() {
                                            print(number.phoneNumber
                                                .substring(1));
                                            phoneno = number
                                                .phoneNumber
                                                .substring(1);
                                            print(phoneno);
                                          });
                                        },
                                        onInputValidated: (bool value) {
                                          print(value);
                                        },
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                        ),
                                        ignoreBlank: false,
                                        autoValidateMode:
                                        AutovalidateMode.disabled,
                                        selectorTextStyle:
                                        TextStyle(color: Colors.black),
                                        initialValue: number,
                                        textFieldController: controller,
                                        formatInput: false,
                                        keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                        inputBorder: OutlineInputBorder(
                                            borderRadius:
                                            const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            )),
                                        onSaved: (PhoneNumber number) {
                                          print('On Saved: $number');
                                        },
                                      ),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: TextFormField(
                                    //     keyboardType: TextInputType.number,
                                    //     onChanged: (value) {
                                    //       setState(() {
                                    //         phoneno = value;
                                    //       });
                                    //     },
                                    //     validator: validateMobile,
                                    //     decoration: InputDecoration(
                                    //         prefixIcon: Icon(
                                    //             Icons.phone_android_outlined,
                                    //             color: Color(0xffE58714)),
                                    //         border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 const BorderRadius.all(
                                    //           const Radius.circular(30.0),
                                    //         )),
                                    //         hintText: 'Phone Number'),
                                    //     onTap: () {
                                    //       _controller.animateTo(
                                    //         _controller
                                    //             .position.maxScrollExtent,
                                    //         duration: Duration(seconds: 1),
                                    //         curve: Curves.fastOutSlowIn,
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.4,
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.06,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        50.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent))),
                                            backgroundColor:
                                            MaterialStateProperty
                                                .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Colors.orange[200];
                                                return Colors.orange[500];
                                              },
                                            ),
                                          ),
                                          child: Text(
                                            'Continue', textScaleFactor: 1,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (validate()) {
                                              setState(() {
                                                isApiCallProcess = true;
                                              });
                                              ApiService apiService =
                                              new ApiService();
                                              PostForgotPassword
                                              postForgotPassword =
                                              new PostForgotPassword(
                                                  admMobile: phoneno);
                                              apiService
                                                  .forgotPassword(
                                                  postForgotPassword)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isApiCallProcess = false;
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VerificatioPagePass(
                                                                otp: value.otp.toString(),
                                                                responseForgotPassword: value,
                                                              )));
                                                }else{
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                    DialogType.WARNING,
                                                    animType:
                                                    AnimType.BOTTOMSLIDE,
                                                    title: 'Try later',
                                                    desc:
                                                    'Unable to change Password',
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () {},
                                                  )..show();
                                                }
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ]))
                        ]))
                  ])
                ],
              ),
            )),
      ),
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  bool validate() {
    if (_formKey.currentState.validate()) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Processing Data')));
      return true;
    } else {
      return false;
    }
  }
}