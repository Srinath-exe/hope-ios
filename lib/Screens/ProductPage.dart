import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hopepoints/Model/ProductlistAll.dart';
import 'package:hopepoints/Model/productTags.dart';
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
      body: Container(
          child: FutureBuilder(
              future: apiService.productlistall(),
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  List<GetProductListAll> productlistall = snapshot1.data;
                  if (productlistall.length != 0) {
                    return FutureBuilder(
                        future: apiService.getProductCtg(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ProductTags> productTags = snapshot.data;
                            return Container(
                                height:
                                MediaQuery.of(context).size.height * 0.95,
                                child: ListView.builder(
                                    itemCount: productTags.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical:5.0),
                                        child: productRow(
                                            productTags[index].prdCustid,
                                            productlistall
                                                .where((e) =>
                                            e.prdCustid ==
                                                "${productTags[index].prdCustid}")
                                                .toList()),
                                      );
                                    }));
                          } else {
                            return Container(
                                height:
                                MediaQuery.of(context).size.height * 0.95,
                                child: Column(
                                  children: [
                                    nullProduct(),
                                    nullProduct(),
                                    nullProduct(),
                                  ],
                                ));
                          }
                        });
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: Column(
                          children: [
                            nullProduct(),
                            nullProduct(),
                            nullProduct(),
                          ],
                        ));
                  }
                } else {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: Column(
                        children: [
                          nullProduct(),
                          nullProduct(),
                          nullProduct(),
                        ],
                      ));
                }
              })),
    );
  }

  Widget productRow(String title, List<GetProductListAll> productList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(' $title',
                    textScaleFactor: 1,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
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
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                        product: productList[index], token: token, uuid: uuid);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
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