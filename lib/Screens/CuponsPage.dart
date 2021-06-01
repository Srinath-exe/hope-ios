import 'package:flutter/material.dart';
import 'package:hopepoints/Model/CuponList.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:hopepoints/widgets/cuponcard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class CuponsPage extends StatefulWidget {
  @override
  _CuponsPageState createState() => _CuponsPageState();
}

class _CuponsPageState extends State<CuponsPage> {
  String token = '';
  String uuid = '';
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  ApiService apiService;
  void gettokenAndUuid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokentemp = preferences.getString('token');
    String uuidtemp = preferences.getString('uuid');
    String login = preferences.getString('logged');
    print(login);

    setState(() {
      token = tokentemp;
      uuid = uuidtemp;
    });
  }
   List<GetCouponList> couponList;
  @override
  void initState() {
    gettokenAndUuid();
    apiService = new ApiService(token: token);
    super.initState();
  }

  Future<Null> refreshList() async {
    apiService.couponlist(uuid).then((value) {
      setState(() {
        couponList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupons',
          textScaleFactor: 1,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: apiService.couponlist(uuid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               couponList = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height * 1.5,
                  child: RefreshIndicator(
                    child: ListView.builder(
                      controller: ScrollController(),
                      physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: couponList.length,
                        itemBuilder: (context, index) {
                          return CuponRedeem(
                              coupon: couponList[index],
                              token: token,
                              uuid: uuid);
                        }),
                    onRefresh: refreshList,
                  ),
                );
              } else {
                return nullCoupon();
              }
            }),
      ),
    );
  }

  Widget nullCoupon() {
    return Container(
      child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        emptycuponcard(),
        emptycuponcard(),
        emptycuponcard(),
      ])),
    );
  }

  Widget emptycuponcard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[100],
                highlightColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.20,
                  color: Colors.grey[100],
                ),
              )),
        ],
      ),
    );
  }
}
