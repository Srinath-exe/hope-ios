import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopepoints/Model/BrandDetails_model.dart';
import 'package:hopepoints/Model/productDetails.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:shimmer/shimmer.dart';

class ProductPage extends StatefulWidget {
  String productId;
  String productName;
  String token;
  String uuid;
  ProductPage({this.productId, this.productName, this.token, this.uuid});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ApiService apiService;
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  @override
  void initState() {
    apiService = new ApiService(token: widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName,
            textScaleFactor: 1, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: apiService.productdetails(pid: widget.productId),
          builder: (context, snapshot) {
            GetProductDetails productDetail = snapshot.data;
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: apiService.getbrandDetails(
                      brandId: productDetail.prdBrandid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GetBrandDetails brandDetail = snapshot.data;
                      return SingleChildScrollView(
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(38),
                                  color: Colors.white,
                                  // image: DecorationImage(
                                  //     image: NetworkImage(
                                  //         imgpath + productDetail.prdImage),
                                  //     fit: BoxFit.fill),
                                ),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 0),
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "${imgpath + productDetail.prdImage}",
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[100],
                                    highlightColor: Colors.white,
                                    child: Container(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Material(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(38),
                                        color: Colors.white,
                                        // image: DecorationImage(
                                        //     image: NetworkImage(imgpath +
                                        //         brandDetail.brdLogo),
                                        //     fit: BoxFit.contain),
                                      ),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 0),
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "${imgpath + brandDetail.brdLogo}",
                                        placeholder: (context, url) =>
                                            Container(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  productDetail.prdName,
                                                  textScaleFactor: 1,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(brandDetail.brdName,
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    child: Text('${productDetail.prdPrice} TZS',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text('${productDetail.prdPoints} ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                      Text('Points ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Container(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text('Product Description:',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Text(productDetail.prdDetail,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
