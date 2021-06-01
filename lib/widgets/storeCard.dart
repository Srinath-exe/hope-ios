import 'package:flutter/material.dart';

import 'package:hopepoints/Model/StoreListAll.dart';

class StoreCard extends StatefulWidget {
 GetStoreListAll storeDetail;
  StoreCard({this.storeDetail});
  @override
  _StorCcardState createState() => _StorCcardState();
}

class _StorCcardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Store Name:' , textScaleFactor: 1,style:TextStyle(fontSize: 15)),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text(
                                widget.storeDetail.strStorename, textScaleFactor: 1,
                                style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600)))
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('City:' , textScaleFactor: 1,),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text(
                                widget.storeDetail.strCity,textScaleFactor: 1,style:TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Address:' , textScaleFactor: 1,),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text(widget.storeDetail.strAddress ,textScaleFactor: 1,))
                                // 'POBOX- 9642, Bongoyo Road, \nOysterbay,Dar Es Salaam, \nTanzania, Eastern Africa.'))
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Zipcode:' , textScaleFactor: 1,),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text(widget.storeDetail.strZipcode,textScaleFactor: 1,))
                                // 'POBOX- 9642, Bongoyo Road, \nOysterbay,Dar Es Salaam, \nTanzania, Eastern Africa.'))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone:' , textScaleFactor: 1,),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text('${widget.storeDetail.strPhone}',textScaleFactor: 1,))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Email:' , textScaleFactor: 1,),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.9 * 0.6,
                            child: Text('${widget.storeDetail.strEmail}',textScaleFactor: 1,))
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}
