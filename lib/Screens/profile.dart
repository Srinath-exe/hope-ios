import 'package:flutter/material.dart';
import 'package:hopepoints/Model/profile_model.dart';
import 'package:hopepoints/Screens/CuponsPage.dart';
import 'package:hopepoints/Screens/TandC.dart';
import 'package:hopepoints/Screens/login.dart';
import 'package:hopepoints/Screens/notificationPage.dart';
import 'package:hopepoints/Screens/referralPage.dart';
import 'package:hopepoints/Screens/storesPage.dart';

import 'package:hopepoints/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String token = '';
  String uuid = '';
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  ApiService apiService;

  String adm = '';
  void gettokenAndUuid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokentemp = preferences.getString('token');
    String uuidtemp = preferences.getString('uuid');
    String login = preferences.getString('logged');
    apiService = new ApiService(token: token);
    print(login);

    setState(() {
      token = tokentemp;
      uuid = uuidtemp;
    });
  }

  @override
  void initState() {
    gettokenAndUuid();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    apiService = new ApiService(token: token);
    print('uuid: $uuid');
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text('Profile',  textScaleFactor: 1, style: TextStyle(color: Colors.black))),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            FutureBuilder(
                future: apiService.getProfile(uuid),
                builder: (context, snapshot) {
                  print('snap : ${snapshot.data}');
                  if (snapshot.hasData) {
                    ProfileModel profile = snapshot.data;
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${profile.admFname} ${profile.admLname}',
                                                  textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
                                            child: Text('${profile.admMobile}',
                                              textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ));
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Shimmer.fromColors(
                                                  baseColor: Colors.grey[100],
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                      color: Colors.grey,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Shimmer.fromColors(
                                                  baseColor: Colors.grey[100],
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                      color: Colors.grey,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ));
                  }
                }),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_activity, color: Colors.green),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Coupons',
                              textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CuponsPage()));
                    });
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.pink[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.store_mall_directory,
                              color: Colors.pink[500]),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Stores',
                              textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.pink[800],
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Stores()));
                    });
                  }),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.yellow[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications, color: Colors.yellow[700]),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Notifications',
                              textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.yellow[800],
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()));
                    });
                  }),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.blue[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.connect_without_contact,
                              color: Colors.blue[700]),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Referral',
                              textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReferralPage()));
                    });
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.grey[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt, color: Colors.black),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Terms and Conditions',
                              textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TnC()));
                    });
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red[100];
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Logout',
                          textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[800],
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.logout, size: 20, color: Colors.redAccent),
                    ],
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString('logged', '');

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
            ),
            // ListTile(
            //   title: Text("Ntotify"),
            //   trailing: Icon(Icons.notifications),
            //   onTap: () {}
            // )
          ],
        ))));
  }
}
