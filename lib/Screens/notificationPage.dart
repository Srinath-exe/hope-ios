import 'package:flutter/material.dart';
import 'package:hopepoints/Model/NotificationUserWise.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
   String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String token = '';
  String uuid = '';
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  ApiService apiService;
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
    return Scaffold(
       appBar: AppBar(
          title: Text(
            'Notifications',
              textScaleFactor: 1,
            style: TextStyle(
      
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
          body:
          
               FutureBuilder(
                  future: apiService.notificationuserwise(uuid),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      List<GetNotificationUserWise> notificationuserwise =
                          snapshot.data;
                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height ,
                        child: ListView.builder(
                            itemCount: notificationuserwise.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: notify(notificationuserwise[index]),
                              );
                            }),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height ,
                          child: Center(
                            child: Container(
                              child: Text('No Notifications',
                                textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.cyan[400])),
                            ),
                          ),
                        );
                      }
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height ,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }));
          //  ),
        
    
  
  }

  // Widget notify(GetNotificationUserWise getNotificationUserWise) {
  //
  //   return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Color(0xff81BFCA), width: 0.1),
  //         ),
  //         child: Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               //  Image.network(url + getNotificationUserWise.msgBnrimg),
  //               Container(
  //                 height: MediaQuery.of(context).size.height * 0.25,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //
  //                     image: DecorationImage(
  //                         image:
  //                             NetworkImage(imgpath+getNotificationUserWise.msgBnrimg),
  //                             fit:BoxFit.fill
  //                 )),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
  //                 child: Container(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                     width:MediaQuery.of(context).size.width*0.9,
  //                         child: Text(
  //                           getNotificationUserWise.msgSubject,
  //                             textScaleFactor: 1,
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               //255222863221
  //
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
  //                 child: Container(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: MediaQuery.of(context).size.width * 0.9,
  //                         child: Text(
  //                           getNotificationUserWise.msgMessage,
  //                             textScaleFactor: 1,
  //                           style: TextStyle(
  //                             fontSize: 13,
  //                             color: Colors.grey[600],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Divider(
  //                 thickness: 3,
  //                 indent: 50,
  //                 endIndent: 50,color: Colors.yellow[900],
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }
  Widget notify(GetNotificationUserWise getNotificationUserWise) {

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff81BFCA), width: 0.1),
          ),
          padding:EdgeInsets.all(8),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //  Image.network(url + getNotificationUserWise.msgBnrimg),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(

                      image: DecorationImage(
                          image:
                          NetworkImage(imgpath+getNotificationUserWise.msgBnrimg),
                          fit:BoxFit.fill
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text(
                            "${getNotificationUserWise.msgSubject}",
                            textScaleFactor: 1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //255222863221

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "${getNotificationUserWise.msgMessage}",
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 3,
                  indent: 50,
                  endIndent: 50,color: Colors.yellow[900],
                )
              ],
            ),
          ),
        ));
  }
}
