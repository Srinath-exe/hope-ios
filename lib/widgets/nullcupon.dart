import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NullCoupon extends StatefulWidget {
  @override
  _NullCouponState createState() => _NullCouponState();
}

class _NullCouponState extends State<NullCoupon> {
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';

  String adm = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:12.0),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:0.0),

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

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),

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
                                    maximum: 250,
                                    showLabels: false,
                                    showTicks: false,
                                    axisLineStyle: AxisLineStyle(
                                      thickness: 2,
                                      color: Colors.white,
                                      thicknessUnit: GaugeSizeUnit.factor,
                                    ),
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: 0,
                                        width: 0.15,
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
                                          widget: Container(
                                            child:
                                            Text('',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ))
                                    ])
                              ]),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.028,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.orange[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.28,
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.2,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.height * 0.08,

                                      child: Shimmer.fromColors(
                                        baseColor: Colors.orange[200],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.28,
                                          width:
                                          MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.grey[100],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ]),
                                  Column(
                                    children: [
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.045,
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.orange[200],
                                          highlightColor: Colors.grey[100],
                                          child: Container(
                                            height: MediaQuery.of(context).size.height *
                                                0.28,
                                            width: MediaQuery.of(context).size.width *
                                                0.40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey[100],
                                            ),
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
      ),
    );
  }
}