// To parse this JSON data, do
//
//     final postValidateOtp = postValidateOtpFromJson(jsonString);

import 'dart:convert';

PostValidateOtp postValidateOtpFromJson(String str) => PostValidateOtp.fromJson(json.decode(str));

String postValidateOtpToJson(PostValidateOtp data) => json.encode(data.toJson());

class PostValidateOtp {
    PostValidateOtp({
        this.otpMobile,
        this.otpUserid,
        this.otpOtp,
    });

    String otpMobile;
    String otpUserid;
    String otpOtp;

    factory PostValidateOtp.fromJson(Map<String, dynamic> json) => PostValidateOtp(
        otpMobile: json["otp_mobile"],
        otpUserid: json["otp_userid"],
        otpOtp: json["otp_otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp_mobile": otpMobile,
        "otp_userid": otpUserid,
        "otp_otp": otpOtp,
    };
}

// To parse this JSON data, do
//
//     final responseValidateOtp = responseValidateOtpFromJson(jsonString);

ResponseValidateOtp responseValidateOtpFromJson(String str) => ResponseValidateOtp.fromJson(json.decode(str));

String responseValidateOtpToJson(ResponseValidateOtp data) => json.encode(data.toJson());

class ResponseValidateOtp {
    ResponseValidateOtp({
        this.admName,
        this.uuid,
        this.admMobile,
        this.admEmail,
        this.admPropic,
        this.admCardnum,
        this.status,
        this.token,
        this.expires,
    });

    String admName;
    String uuid;
    String admMobile;
    String admEmail;
    String admPropic;
    String admCardnum;
    String status;
    String token;
    int expires;

    factory ResponseValidateOtp.fromJson(Map<String, dynamic> json) => ResponseValidateOtp(
        admName: json["adm_name"],
        uuid: json["uuid"],
        admMobile: json["adm_mobile"],
        admEmail: json["adm_email"],
        admPropic: json["adm_propic"],
        admCardnum: json["adm_cardnum"],
        status: json["status"],
        token: json["token"],
        expires: json["expires"],
    );

    Map<String, dynamic> toJson() => {
        "adm_name": admName,
        "uuid": uuid,
        "adm_mobile": admMobile,
        "adm_email": admEmail,
        "adm_propic": admPropic,
        "adm_cardnum": admCardnum,
        "status": status,
        "token": token,
        "expires": expires,
    };
}
