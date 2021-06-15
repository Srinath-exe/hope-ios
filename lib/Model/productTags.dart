// To parse this JSON data, do
//
//     final productTags = productTagsFromJson(jsonString);

import 'dart:convert';

List<ProductTags> productTagsFromJson(String str) => List<ProductTags>.from(json.decode(str).map((x) => ProductTags.fromJson(x)));

String productTagsToJson(List<ProductTags> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductTags {
  ProductTags({
    this.prdCustid,
  });

  String prdCustid;

  factory ProductTags.fromJson(Map<String, dynamic> json) => ProductTags(
    prdCustid: json["prd_custid"],
  );

  Map<String, dynamic> toJson() => {
    "prd_custid": prdCustid,
  };
}