import 'package:flutter/material.dart';
import 'package:hopepoints/Model/OffersList.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:hopepoints/utils/sharedPrefs.dart';
import 'package:hopepoints/widgets/offerCardsvert.dart';
import 'package:hopepoints/widgets/offersCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  ApiService apiService;
  String token = '';
  String uuid = '';
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

  @override
  void initState() {
    super.initState();
    gettokenAndUuid();
  }

  String imgpath = "http://app.hopeholding.co.tz/usrfiles/";
  @override
  Widget build(BuildContext context) {
    apiService = new ApiService(token: sharedPrefs.tokentemp);
    print('token : $token');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Text('  Offers',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              ],
            ),
            offers(),
            Row(
              children: [
                Text('  Top Offers',
                  textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
            fas(),
          ]),
        ),
      ),
    );
  }

  Widget offers() {
    return FutureBuilder(
      future: apiService.offerslist(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<GetOffersList> offerLis = snapshot.data;
          List<GetOffersList> offerList =
              offerLis.where((e) => e.ofrStatus == "2").toList();
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: offerList.length,
                itemBuilder: (context, index) {
                  return OffersCard(
                    offerList: offerList[index],
                  );
                }),
          );
        } else {
          return nilloffers();
        }
      },
    );
  }

  Widget fas() {
    return FutureBuilder(
      future: apiService.offerslist(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<GetOffersList> offerLis = snapshot.data;
          List<GetOffersList> offerList =
              offerLis.where((e) => e.ofrStatus == "3").toList();
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: offerList.length,
                itemBuilder: (context, index) {
                  return OffersCardvert(
                    offerList: offerList[index],
                  );
                }),
          );
        } else {
          return nullOffer(); //TODO:
        }
      },
    );
  }

  Widget nullOffer() {
    return Container(
      child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        emptyOffercard(),
      ])),
    );
  }

  Widget emptyOffercard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[100],
            highlightColor: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.grey[100],
            ),
          )),
    );
  }

  nilloffers() {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            emptyOfferscard(),
            emptyOfferscard(),
            emptyOfferscard(),
          ])),
    );
  }

  emptyOfferscard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[100],
            highlightColor: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.40,
              color: Colors.grey[100],
            ),
          )),
    );
  }
}
