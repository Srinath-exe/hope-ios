import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopepoints/Model/ProductlistAll.dart';
import 'package:hopepoints/Screens/productDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatefulWidget {
  GetProductListAll product;
  String token;
  String uuid;

  ProductCard({this.product, this.token, this.uuid});

  @override
  Product_CardState createState() => Product_CardState();
}

class Product_CardState extends State<ProductCard> {
  String imgpath = 'http://app.hopeholding.co.tz/usrfiles/';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: widget.product.prdId,
                token: widget.token,
                uuid: widget.uuid,
                productName: widget.product.prdName,
              ),
            ),
          );
        },
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.grey[500],
                  //   offset: Offset(0.0, 1.0), //(x,y)
                  //   blurRadius: 2.0,
                  // ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 0),
                      imageUrl: "${imgpath + widget.product.prdImage}",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[100],
                        highlightColor: Colors.white,
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.20 * 0.6,
                          width: MediaQuery.of(context).size.width * 0.35,
                          color: Colors.grey,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: Text(
                          widget.product.prdName,
                            textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          )),
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
