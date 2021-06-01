// To parse this JSON data, do
//
//     final getWalletDetail = getWalletDetailFromJson(jsonString);

import 'dart:convert';

GetWalletDetail getWalletDetailFromJson(String str) => GetWalletDetail.fromJson(json.decode(str));

String getWalletDetailToJson(GetWalletDetail data) => json.encode(data.toJson());

class GetWalletDetail {
    GetWalletDetail({
        this.prcId,
        this.prcUserid,
        this.prcMobile,
        this.prcStoreid,
        this.prcCashierid,
        this.prcStrtdate,
        this.prcInvoice,
        this.prcCoupon,
        this.prcStatus,
        this.points,
        this.amount,
        this.usrFname,
        this.usrLname,
        this.strName,
    });

    dynamic prcId;
    dynamic prcUserid;
    dynamic prcMobile;
    dynamic prcStoreid;
    dynamic prcCashierid;
    dynamic prcStrtdate;
    dynamic prcInvoice;
    dynamic prcCoupon;
    dynamic prcStatus;
    dynamic points;
    dynamic amount;
    dynamic usrFname;
    dynamic usrLname;
    dynamic strName;

    factory GetWalletDetail.fromJson(Map<String, dynamic> json) => GetWalletDetail(
        prcId: json["prc_id"],
        prcUserid: json["prc_userid"],
        prcMobile: json["prc_mobile"],
        prcStoreid: json["prc_storeid"],
        prcCashierid: json["prc_cashierid"],
        prcStrtdate: json["prc_strtdate"],
        prcInvoice: json["prc_invoice"],
        prcCoupon: json["prc_coupon"],
        prcStatus: json["prc_status"],
        points: json["points"],
        amount: json["amount"],
        usrFname: json["usr_fname"],
        usrLname: json["usr_lname"],
        strName: json["str_name"],
    );

    Map<String, dynamic> toJson() => {
        "prc_id": prcId,
        "prc_userid": prcUserid,
        "prc_mobile": prcMobile,
        "prc_storeid": prcStoreid,
        "prc_cashierid": prcCashierid,
        "prc_strtdate": prcStrtdate,
        "prc_invoice": prcInvoice,
        "prc_coupon": prcCoupon,
        "prc_status": prcStatus,
        "points": points,
        "amount": amount,
        "usr_fname": usrFname,
        "usr_lname": usrLname,
        "str_name": strName,
    };
}
