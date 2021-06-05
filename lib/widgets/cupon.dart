import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopepoints/Model/WalletModel.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CuponCard extends StatefulWidget {
  GetWalletDetail walletDetail;
  CuponCard({this.walletDetail});
  @override
  _CuponCardState createState() => _CuponCardState();
}

class _CuponCardState extends State<CuponCard>with SingleTickerProviderStateMixin  {
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
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller) ..addStatusListener((state) => print('$state'));
    gettokenAndUuid();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    apiService = new ApiService(token: token);
    print('uuid: $uuid');

    int point = double.parse(widget.walletDetail.points ?? '0').round();
    double p = double.parse(point.toString());
    //  double.parse(widget.walletDetail.points);
    num max = 250;

    for (int i = 250; i <= point; i = i + 250) {
      max = i + 250;
    }
    //  if(point<250){
    //     max = 250;

    //  }else if(point<500){
    //   max = 500;
    //   }else if(point<750){
    //   max = 750;
    //   }else if(point<1000){
    //   max = 1000;
    //   }else if(point<1500){
    //     max=1500;
    //   }

    num rest = max - double.parse(widget.walletDetail.points ?? '0');
    int more = rest.toInt();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey[100],
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 0.7,
                  transform: GradientRotation(0),
                  colors: <Color>[Colors.orange[50], Colors.orange[100]],
                  tileMode: TileMode.repeated,
                ).createShader(bounds);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // color: Colors.orange[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     offset: Offset(0.0, 1.0), //(x,y)
                  //     blurRadius: 6.0,
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.9 * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  startAngle: 270,
                                  endAngle: 270,
                                  minimum: 0,
                                  maximum: max.toDouble(),
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 1,
                                    color: Colors.white,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: p,
                                      width: 0.0,
                                      color: Colors.green,
                                      pointerOffset: 0.1,
                                      cornerStyle: CornerStyle.bothCurve,
                                      sizeUnit: GaugeSizeUnit.factor,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        positionFactor: 0.5,
                                        angle: 90,
                                        widget: Text(
                                            "${widget.walletDetail.points}",
                                            textScaleFactor: 1,
                                            //  "${widget.walletDetail.points}",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ))))
                                  ])
                            ]),
                          ),
                          Text(
                              "${widget.walletDetail.usrFname}  ${widget.walletDetail.usrLname}",
                              textScaleFactor: 1,
                              style: GoogleFonts.courgette(
                                  textStyle: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                // width: MediaQuery.of(context).size.width * 0.45,
                                                child: Text(
                                                  // "200 Points",
                                                    '${widget.walletDetail.points} Points',
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w700)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text('$more more coins to next reward',
                                    //     textScaleFactor: 1,
                                    //     style: TextStyle(
                                    //         fontSize: 12,
                                    //         color: Colors.white,
                                    //         fontWeight: FontWeight.w500)),
                                    Row(
                                      children: [
                                        Container(
                                          //  width: MediaQuery.of(context).size.width * 0.45,
                                          child: Text(
                                              '${widget.walletDetail.prcMobile}',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.normal)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height * 0.045,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${widget.walletDetail.amount ?? 0}  TZS',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}