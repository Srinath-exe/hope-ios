import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hopepoints/Model/ProductlistAll.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:hopepoints/widgets/productCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProductMain extends StatefulWidget {
  @override
  _ProductMainState createState() => _ProductMainState();
}

class _ProductMainState extends State<ProductMain> {
  ApiService apiService;
  String token = '';
  String uuid = '';

  @override
  void initState() {
    super.initState();
    apiService = new ApiService(token: token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            topDeals(),
            fashion(),
            footwears(),
            cosmetics(),
            papaRoti(),
            // Row(
            //   children: [
            //     Text('  Pappa Roti',
            //         style:
            //             TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            //   ],
            // ),
            // pappaRoti(),
          ]),
        ),
      ),
    );
  }

  Widget topDeals() {
    return FutureBuilder(
        future: apiService.productlistall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetProductListAll> productlistall = snapshot.data;
            List<GetProductListAll> productlistall1 =
            productlistall.where((e) => e.prdCustid == "New").toList();
            if (productlistall1.length != 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('  New Products',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productlistall1.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: productlistall1[index],
                                  token: token,
                                  uuid: uuid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return nullProduct();
          }
        });
  }

  Widget fashion() {
    return FutureBuilder(
        future: apiService.productlistall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetProductListAll> productlistall = snapshot.data;
            List<GetProductListAll> productlistall1 =
            productlistall.where((e) => e.prdCustid == "Fashion").toList();
            if (productlistall1.length != 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('  Fashion & Clothing',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productlistall1.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: productlistall1[index],
                                  token: token,
                                  uuid: uuid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return nullProduct();
          }
        });
  }

  Widget footwears() {
    return FutureBuilder(
        future: apiService.productlistall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetProductListAll> productlistall = snapshot.data;
            List<GetProductListAll> productlistall1 =
            productlistall.where((e) => e.prdCustid == "Footwear").toList();
            if (productlistall1.length != 0) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('  Footwears',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productlistall1.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: productlistall1[index],
                                  token: token,
                                  uuid: uuid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return nullProduct();
          }
        });
  }

  Widget cosmetics() {
    return FutureBuilder(
        future: apiService.productlistall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetProductListAll> productlistall = snapshot.data;
            List<GetProductListAll> productlistall1 = productlistall
                .where((e) => e.prdCustid == "Cosmetics")
                .toList();
            log("prd ${productlistall1.length}");
            if (productlistall1.length != 0) {
              log("prsd $productlistall1");
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('  Cosmetics & Bodycare',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productlistall1.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: productlistall1[index],
                                  token: token,
                                  uuid: uuid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return nullProduct();
          }
        });
  }

  Widget papaRoti() {
    return FutureBuilder(
        future: apiService.productlistall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetProductListAll> productlistall = snapshot.data;
            List<GetProductListAll> productlistall1 =
            productlistall.where((e) => e.prdCustid == "PapaRoti").toList();
            log("prd ${productlistall1.length}");
            if (productlistall1.length != 0) {
              log("prsd $productlistall1");
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Pappa Roti',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            cacheExtent: 1000,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productlistall1.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: productlistall1[index],
                                  token: token,
                                  uuid: uuid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return nullProduct();
          }
        });
  }

  Widget nullProduct() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            emptyProductCard(),
            emptyProductCard(),
            emptyProductCard(),
          ],
        ));
  }

  Widget emptyProductCard() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[100],
                    highlightColor: Colors.white,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20 * 0.6,
                      width: MediaQuery.of(context).size.width * 0.35,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[100],
                        highlightColor: Colors.white,
                        child: Container(
                            height:
                            MediaQuery.of(context).size.height * 0.20 * 0.1,
                            width:
                            MediaQuery.of(context).size.width * 0.35 * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50))),
                      )
                    ],
                  )
                ]),
          ),
        ));
  }
}