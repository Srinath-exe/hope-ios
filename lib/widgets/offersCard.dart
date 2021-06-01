import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hopepoints/Model/OffersList.dart';
import 'package:shimmer/shimmer.dart';

class OffersCard extends StatefulWidget {
  GetOffersList offerList;
  OffersCard({this.offerList});
  @override
  _OffersCardState createState() => _OffersCardState();
}

class _OffersCardState extends State<OffersCard> {
  var imagePath = "http://app.hopeholding.co.tz/usrfiles/";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[100],
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                // image: DecorationImage(
                //     image: NetworkImage(imagePath + widget.offerList.ofrBnrimg),
                //     fit: BoxFit.fill),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: "${imagePath + widget.offerList.ofrBnrimg}",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[100],
                  highlightColor: Colors.white,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.40,
                    color: Colors.grey[100],
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )),
      ),
    );
  }
}
