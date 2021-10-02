import 'package:flutter/material.dart';
import 'package:hopepoints/Model/CuponList.dart';
import 'package:jiffy/jiffy.dart';

class CuponRedeem extends StatefulWidget {
  GetCouponList coupon;
  String token;
  String uuid;

  CuponRedeem({this.coupon, this.token, this.uuid});
  @override
  _CuponRedeemState createState() => _CuponRedeemState();
}

class _CuponRedeemState extends State<CuponRedeem> {
  @override
  Widget build(BuildContext context) {
    String date = Jiffy(widget.coupon.cpnEnddate).yMMMMd;
    String strdate = Jiffy(widget.coupon.cpnStrtdate).yMMMMd;
    print(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                           '${widget.coupon.cpnName}',
                        textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9 * 0.85,
                      // height: MediaQuery.of(context).size.height * 0.12,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                         
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                      textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text('${widget.coupon.cpnAmount} TZS',
                                      textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Cupon Number:\n',
                                ),

                                TextSpan(
                                    text: '  ${widget.coupon.cpnNumber}\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),


                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.9 * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          widget.coupon.cpnStatus == 'Active'
                                              ? 'Started from'
                                              : 'Started from',
                                                textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500)),
                                      Text('$strdate',
                                        textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: true == true
                                                  ? Colors.black
                                                  : Colors.red[900],
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          widget.coupon.cpnStatus == 'Active'
                                              ? 'Expires on'
                                              : 'Expired',
                                                textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500)),
                                      Text('$date',
                                        textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: true == true
                                                  ? Colors.black
                                                  : Colors.red[900],
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ]),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: widget.coupon.cpnStatus == 'Active'
                                      ? Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.05,
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
                                                      return Colors.blue[200];
                                                    return Colors.blue[500];
                                                  },
                                                ),
                                              ),
                                              child: Text(
                                                'Redeem',
                                                  textScaleFactor: 1,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {});
                                              }),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.05,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      side: BorderSide(
                                                          color: Colors.red))),
                                              backgroundColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed))
                                                    return Colors.red[400];
                                                  return Colors.white;
                                                },
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              'Redeemed',
                                                textScaleFactor: 1,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        )),
                              SizedBox(height: MediaQuery.of(context).size.width * 0.035),
                              Text('* Terms and Conditons Applies',style:TextStyle(fontSize:10, color: Colors.grey)),
                            ],
                          ),

                        ],
                      ),
                    ),


                    
                  ],
                )
              ],
            )),
      ),
    );
  }
}
