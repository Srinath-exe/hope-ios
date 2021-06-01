// To parse this JSON data, do
//
//     final postRegister = postRegisterFromJson(jsonString);

import 'dart:convert';

PostRegister postRegisterFromJson(String str) => PostRegister.fromJson(json.decode(str));

String postRegisterToJson(PostRegister data) => json.encode(data.toJson());

class PostRegister {
    PostRegister({
        this.admFname,
        this.admLname,
        this.admMobile,
        this.admRefferedBy,
        this.admSecret,
        this.admToken,
        this.admCoupon,
    });

    String admFname;
    String admLname;
    String admMobile;
    String admRefferedBy;
    String admSecret;
    String admToken;
    String admCoupon;

    factory PostRegister.fromJson(Map<String, dynamic> json) => PostRegister(
        admFname: json["adm_fname"],
        admLname: json["adm_lname"],
        admMobile: json["adm_mobile"],
        admRefferedBy: json["adm_refferedBy"],
        admSecret: json["adm_secret"],
        admToken: json["adm_token"],
        admCoupon: json["adm_coupon"],
    );

    Map<String, dynamic> toJson() => {
        "adm_fname": admFname,
        "adm_lname": admLname,
        "adm_mobile": admMobile,
        "adm_refferedBy": admRefferedBy,
        "adm_secret": admSecret,
        "adm_token": admToken,
        "adm_coupon": admCoupon,
    };
}

// To parse this JSON data, do

ResponseSignUp responseSignUpFromJson(String str) => ResponseSignUp.fromJson(json.decode(str));

String responseSignUpToJson(ResponseSignUp data) => json.encode(data.toJson());

class ResponseSignUp {
    ResponseSignUp({
        this.otp,
        this.error,
        this.uuid,
    });

    int otp;
    bool error;
    String uuid;

    factory ResponseSignUp.fromJson(Map<String, dynamic> json) => ResponseSignUp(
        otp: json["otp"],
        error: json["error"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
        "error": error,
        "uuid": uuid,
    };
}
