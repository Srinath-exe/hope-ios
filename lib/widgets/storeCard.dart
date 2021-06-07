import 'package:flutter/material.dart';

import 'package:hopepoints/Model/StoreListAll.dart';
import 'package:url_launcher/url_launcher.dart';


class StoreCard extends StatefulWidget {
  GetStoreListAll storeDetail;
  StoreCard({this.storeDetail});
  @override
  _StorCcardState createState() => _StorCcardState();
}

class _StorCcardState extends State<StoreCard> {

  @override
  Widget build(BuildContext context) {

    // Future<void> customLaunch(command) async {
    //   if (await canLaunch(command)) {
    //     print("launched");
    //     await launch(command);
    //   } else {
    //     print(' could not launch $command');
    //   }
    // }
    String command="tel://${widget.storeDetail.strPhone}";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name:',
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 14)),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(widget.storeDetail.strStorename,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'City:',
                              textScaleFactor: 1,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(widget.storeDetail.strCity,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address:',
                              textScaleFactor: 1,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(
                                  widget.storeDetail.strAddress,
                                  textScaleFactor: 1,
                                ))
                            // 'POBOX- 9642, Bongoyo Road, \nOysterbay,Dar Es Salaam, \nTanzania, Eastern Africa.'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Zipcode:',
                              textScaleFactor: 1,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(
                                  widget.storeDetail.strZipcode,
                                  textScaleFactor: 1,
                                ))
                            // 'POBOX- 9642, Bongoyo Road, \nOysterbay,Dar Es Salaam, \nTanzania, Eastern Africa.'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone:',
                              textScaleFactor: 1,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(
                                  '${widget.storeDetail.strPhone}',
                                  textScaleFactor: 1,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email:',
                              textScaleFactor: 1,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    0.9 *
                                    0.7,
                                child: Text(
                                  '${widget.storeDetail.strEmail}',
                                  textScaleFactor: 1,
                                ))
                          ],
                        )
                      ]),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),

                          onPressed: () {
                                                _launchURL("tel:+${widget.storeDetail.strPhone}");
                            // _launchURL("tel:+${widget.storeDetail.strPhone}");
                          //  customLaunch(command);

                          },
                          iconSize: 25,
                          icon: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return RadialGradient(
                                center: Alignment.topLeft,
                                radius: 0.5,
                                colors: <Color>[
                                  Colors.orange[200],
                                  Colors.yellow[200]
                                ],
                                tileMode: TileMode.repeated,
                              ).createShader(bounds);
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            _launchURL("mailto:${widget.storeDetail.strEmail}");
                            launch("mailto:${widget.storeDetail.strEmail}");
                          },
                          iconSize: 25,
                          icon: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return RadialGradient(
                                center: Alignment.topLeft,
                                radius: 0.5,
                                colors: <Color>[
                                  Colors.orange[200],
                                  Colors.yellow[200]
                                ],
                                tileMode: TileMode.repeated,
                              ).createShader(bounds);
                            },
                            child: Icon(
                              Icons.email,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}