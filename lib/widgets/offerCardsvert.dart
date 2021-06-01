import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hopepoints/Model/OffersList.dart';

class OffersCardvert extends StatefulWidget {
  GetOffersList offerList;
  OffersCardvert({this.offerList});

  @override
  _OffersCardvertState createState() => _OffersCardvertState();
}

class _OffersCardvertState extends State<OffersCardvert> {
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
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(imagePath + widget.offerList.ofrBnrimg),
                    fit: BoxFit.fill),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: "${imagePath + widget.offerList.ofrBnrimg}",
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )),
      ),
    );
  }
}
