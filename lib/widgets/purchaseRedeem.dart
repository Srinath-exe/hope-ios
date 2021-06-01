import 'package:flutter/material.dart';
import 'package:hopepoints/Model/PurchaseSelectAll.dart';
import 'package:hopepoints/Screens/purchaseDetails.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class PurchaseWallet extends StatefulWidget {
  @override
  _PurchaseWalletState createState() => _PurchaseWalletState();
}

class _PurchaseWalletState extends State<PurchaseWallet> {
  ApiService apiService;
  String token = '';
  String uuid = '';
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
    return purchase();
  }

  Widget purchase() {
    return FutureBuilder(
        future: apiService.getPurchasesSelectAll(uuid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetPurchasesSelectAll> purchasesSelectAll = snapshot.data;
            purchasesSelectAll = purchasesSelectAll.length > 4
                ? purchasesSelectAll.sublist(0, 5)
                : purchasesSelectAll;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: purchasesSelectAll.length,
              itemBuilder: (context, index) {
                return purchasecard1(purchasesSelectAll[index]);
              },
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Purchases Yet",
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ),
              );
            }
            return nullPurchase();
          }
        });
  }

  Widget purchasecard1(GetPurchasesSelectAll getPurchasesSelectAll) {
    String date = Jiffy(getPurchasesSelectAll.prcStrtdate).yMMMMd;
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Material(
        shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchaseDetails(
                        getPurchasesSelectAll: getPurchasesSelectAll)));
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              padding: const EdgeInsets.all(8.0),
                              child: (true)
                                  ? Icon(Icons.shopping_bag,
                                      color: Colors.blue[300])
                                  : Icon(Icons.restaurant,
                                      color: Colors.blue[300]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //color: Colors.amber,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(getPurchasesSelectAll.strName,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(date,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${getPurchasesSelectAll.prcAmountpaid} TZS",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Text("${getPurchasesSelectAll.prcPointspent}",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green[800],
                                        fontWeight: FontWeight.w600)),
                                Text(" Points",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green[800],
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 2,
                    thickness: 1,
                    indent: 45,
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget nullPurchase() {
    return SingleChildScrollView(
        child: Container(
      child: Column(children: [
        purchaselaod(),
        purchaselaod(),
      ]),
    ));
  }

  Widget purchaselaod() {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Material(
        shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.068,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[100],
                      highlightColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.95,
                      ),
                    )),
                Divider(
                  height: 2,
                  thickness: 1,
                  indent: 45,
                )
              ],
            )),
      ),
    );
  }
}
