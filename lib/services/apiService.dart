import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hopepoints/Model/BrandDetails_model.dart';
import 'package:hopepoints/Model/BrandList_model.dart';
import 'package:hopepoints/Model/CuponList.dart';
import 'package:hopepoints/Model/ForgotPassword.dart';
import 'package:hopepoints/Model/Login_model.dart';
import 'package:hopepoints/Model/NotificationUserWise.dart';
import 'package:hopepoints/Model/OffersList.dart';
import 'package:hopepoints/Model/ProductlistAll.dart';
import 'package:hopepoints/Model/PurchaseSelectAll.dart';
import 'package:hopepoints/Model/StoreListAll.dart';
import 'package:hopepoints/Model/WalletModel.dart';
import 'package:hopepoints/Model/postvalidateOtp.dart';
import 'package:hopepoints/Model/productDetails.dart';
import 'package:hopepoints/Model/productTags.dart';
import 'package:hopepoints/Model/profile_model.dart';
import 'package:hopepoints/Model/register_model.dart';
import 'package:hopepoints/Model/tnc_mode.dart';
import 'package:hopepoints/utils/sharedPrefs.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String baseUrl = 'https://app.hopeholding.co.tz/api/public';
  final String token;
  ApiService({this.token});
  String gettoken() {
    return sharedPrefs.tokentemp;
  }

  // Map<String,String> headerlist={
  //     HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
  //   };
  Future<ResponseLogin> login(PostLogin loginModel) async {
    var url = Uri.parse(baseUrl + "/token");
    var response = await http.post(url, body: postLoginToJson(loginModel));
    print('Login response Status: ${response.statusCode}');
    print('Login response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', 'Bearer ${responseLogin.token}');
      preferences.setString('uuid', '${responseLogin.uuid}');
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseSignUp> signUp(PostRegister registermodel) async {
    var url = Uri.parse(baseUrl + "/admin_accountsCreate");
    var response = await http.post(
      url,
      body: postRegisterToJson(registermodel),
    );
    print('singup  body: ${postRegisterToJson(registermodel)}');
    print('Singup response status: ${response.statusCode}');
    print('singup response body: ${response.body}');
    if (response.statusCode == 201) {
      try {
        ResponseSignUp responseSignUp = responseSignUpFromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('token', 'Bearer ${responseSignUp.token}');
        preferences.setString('uuid', '${responseSignUp.uuid}');

        return responseSignUp;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  //Validate Otp
  Future<ResponseValidateOtp> validateOtp(
      PostValidateOtp postValidateOtp) async {
    var url = Uri.parse(baseUrl + "/users_validateOTP");
    var response = await http.post(
      url,
      body: postValidateOtpToJson(postValidateOtp),
    );
    print('validateOtp response status: ${response.statusCode}');
    print('validateOtp response body: ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 201) {
      try {
        ResponseValidateOtp responseValidateOtp =
            responseValidateOtpFromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', 'Bearer ${responseValidateOtp.token}');
        return responseValidateOtp;
      } catch (e) {
        return null;
      }
    } else
      return null;
  }

  Future<List<GetBrandList>> brandlist() async {
    String fileName = "brandList.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("brandlist type : local");
      var jsonData = file.readAsStringSync();
      List<GetBrandList> getBrandList = getBrandListFromJson(jsonData);
      return getBrandList;
    } else {
      log("brandlist type : api");
      var url = Uri.parse(baseUrl + "/system_brandsSelectAll/0/100");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('brandlist response status: ${response.statusCode}');
      print('brandlist response body: ${response.body}');
      if (response.statusCode == 201) {
        List<GetBrandList> getBrandList = getBrandListFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return getBrandList;
      } else
        return [];
    }
  }

  Future<GetBrandDetails> getbrandDetails({String brandId}) async {
    String fileName = "branddetail_$brandId.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("branddetail_$brandId type : local");
      var jsonData = file.readAsStringSync();
      GetBrandDetails getBrandDetails = getBrandDetailsFromJson(jsonData);
      return getBrandDetails;
    } else {
      log("branddetail_$brandId type : api");
      var url = Uri.parse(baseUrl + "/system_brandsSelectOne/$brandId");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('get Brand Detail response status: ${response.statusCode}');
      print('get Brand Detail body: ${response.body}');
      if (response.statusCode == 201) {
        GetBrandDetails getBrandDetails =
            getBrandDetailsFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return getBrandDetails;
      } else
        return null;
    }
  }

  Future<List<GetProductListAll>> productlistall() async {
    String fileName = "productData.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("type : local");
      var jsonData = file.readAsStringSync();
      List<GetProductListAll> getproductlistall =
          getProductListAllFromJson(jsonData);
      return getproductlistall;
    } else {
      log("type : api");
      var url = Uri.parse(baseUrl + "/system_productsSelectAll/0/100");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      log('product List response status: ${response.statusCode}');
      log('ProductList response body: ${response.body}');
      if (response.statusCode == 201) {
        List<GetProductListAll> getproductlistall =
            getProductListAllFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return getproductlistall;
      } else
        return null;
    }
  }

  Future<GetProductDetails> productdetails({String pid}) async {
    String fileName = "productdetail_$pid.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("productdetails $pid type : local");
      var jsonData = file.readAsStringSync();
      GetProductDetails productDetail = getProductDetailsFromJson(jsonData);
      return productDetail;
    } else {
      log("productdetails $pid type : api");
      var url = Uri.parse(baseUrl + "/system_productsSelectOne/$pid");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('product detail response status: ${response.statusCode}');
      print('product Detail response body: ${response.body}');
      if (response.statusCode == 201) {
        var jsonRespose = response.body;
        GetProductDetails productDetail =
            getProductDetailsFromJson(response.body);
            file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return productDetail;
      } else
        return null;
    }
  }

  Future<List<GetStoreListAll>> storelistall() async {
    var url = Uri.parse(baseUrl + "/system_storeSelectUnlimited");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
    });
    print('storelistall response status: ${response.statusCode}');
    debugPrint('storelistall response body: ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        print('dsfs ${getStoreListAllFromJson(response.body)}');
        List<GetStoreListAll> storeList =
            getStoreListAllFromJson(response.body);
        return storeList;
      } catch (e) {
        return null;
      }
    } else
      return null;
  }

  Future<ResponseLogin> storedetail() async {
    var url = Uri.parse(baseUrl + "/system_storeSelectOne/{str_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else {
      return null;
    }
  }

  Future<ResponseLogin> notificationcount() async {
    var url = Uri.parse(baseUrl + "/users_notificationCountOpen/{uuid}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<List<GetNotificationUserWise>> notificationuserwise(
      String uuid) async {
    var url = Uri.parse(baseUrl + "/users_notificationSelectAll/ADM2/0/100");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
    });
    print('notification response status: ${response.statusCode}');
    print('notification response body: ${response.body}');
    if (response.statusCode == 201) {
      try {
        List<GetNotificationUserWise> notificationuserwise =
            getNotificationUserWiseFromJson(response.body);
        return notificationuserwise;
      } catch (e) {
        return null;
      }
    } else
      return null;
  }

  Future<ResponseLogin> notificationdetails() async {
    var url =
        Uri.parse(baseUrl + "/users_notificationSelectOne/{uuid}/{msg_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseLogin> notificationdelete() async {
    var url = Uri.parse(baseUrl + "/users_notificationDelete/{uuid}/{msg_id}");
    var response = await http.get(
      url,
    );
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<List<GetOffersList>> offerslist() async {
    String fileName = "offerslist.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("offerslist type : local");
      var jsonData = file.readAsStringSync();
      List<GetOffersList> getOffersList = getOffersListFromJson(jsonData);
      return getOffersList;
    } else {
      log(" offerslist type : api");
      var url = Uri.parse(baseUrl + "/system_offersSelectUnlimited");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('OffersList response status: ${response.statusCode}');
      print('OffersList response body: ${response.body}');
      if (response.statusCode == 201) {
        List<GetOffersList> getOffersList =
            getOffersListFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return getOffersList;
      } else
        return null;
    }
  }

  Future<ResponseLogin> offersdetails() async {
    var url = Uri.parse(baseUrl + "/system_offersSelectOne/{ofr_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<List<GetCouponList>> couponlist(String uuid) async {
    var url = Uri.parse(baseUrl + "/system_couponsSelectUnlimited/$uuid");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
    });
    print('CouponList response status: ${response.statusCode}');
    print('CouponList response body: ${response.body}');
    if (response.statusCode == 201) {
      List<GetCouponList> getCouponList = getCouponListFromJson(response.body);
      return getCouponList;
    } else
      return null;
  }

  Future<ResponseLogin> coupondetails() async {
    var url = Uri.parse(baseUrl + "/system_couponsSelectOne/{cpn_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseLogin> customerpurchaseslist() async {
    var url =
        Uri.parse(baseUrl + "/users_purchasesSelectAll/{uuid}/{skp}/{lmt}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseLogin> customerpurchasedetails() async {
    var url = Uri.parse(baseUrl + "/users_purchasesSelectOne/{uuid}/{prc_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseLogin> customercouponslist(String uuid) async {
    var url = Uri.parse(baseUrl + "/users_mycouponsSelectAll/$uuid");
    var response = await http.get(url);
    print(' myCoupons response status: ${response.statusCode}');
    print('myCoupons response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ResponseLogin> customercouponsdetails() async {
    var url = Uri.parse(baseUrl + "/users_purchasesSelectOne/{uuid}/{mcp_id}");
    var response = await http.get(url);
    print('brandlist response status: ${response.statusCode}');
    print('brandlist response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseLogin responseLogin = responseLoginFromJson(response.body);
      return responseLogin;
    } else
      return null;
  }

  Future<ProfileModel> getProfile(String adm) async {
    String fileName = "profile$adm.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log("getProfile type : local");
      var jsonData = file.readAsStringSync();
      ProfileModel profile = profileModelFromJson(jsonData);
      return profile;
    } else {
      log("getProfile type : api");
      print('uuid $adm');
      var url = Uri.parse(baseUrl + "/admin_accountsSelectOne/$adm");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('Profile data ${response.body}');
      if (response.statusCode == 201) {
        ProfileModel profile = profileModelFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return profile;
      } else {
        return null;
      }
    }
  }

  Future<ResponseForgotPassword> forgotPassword(
      PostForgotPassword forgotPasswordmodel) async {
    var url = Uri.parse(baseUrl + "/admin_paswrdsForgot");
    var response = await http.post(url,
        body: postForgotPasswordToJson(forgotPasswordmodel));
    print('forgotPassword response Status: ${response.statusCode}');
    print('forgotPassword response body: ${response.body}');
    if (response.statusCode == 201) {
      ResponseForgotPassword responseForgotPassword =
          responseForgotPasswordFromJson(response.body);

      return responseForgotPassword;
    } else
      return null;
  }

  Future<bool> resetPassword(PostResetPassword postResetPassword) async {
    var url = Uri.parse(baseUrl + "/admin_paswrdsReset");
    var response =
        await http.post(url, body: postResetPasswordToJson(postResetPassword));
    print('resetPassword response Status: ${response.statusCode}');
    print('resetPassword response body: ${response.body}');
    if (response.statusCode == 201) {
      if (response.body.length == 8) {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  Future<GetWalletDetail> getWallet(String admId) async {
    String fileName = "wallet.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    print(admId);
    if (file.existsSync()) {
      log("getWallet type : local");
      var jsonData = file.readAsStringSync();
      GetWalletDetail getWallet = getWalletDetailFromJson(jsonData);
      return getWallet;
    } else {
      log("getWallet type : api");

      var url = Uri.parse(baseUrl + "/users_purchasesSelectMy/$admId");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('getWallet response Status: ${response.statusCode}');
      print('getWallet response body: ${response.body}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        try {
          GetWalletDetail getWallet = getWalletDetailFromJson(response.body);
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
          return getWallet;
        } catch (e) {
          print('snap: error');
          return null;
        }
      } else
        return null;
    }
  }

  Future<List<GetPurchasesSelectAll>> getPurchasesSelectAll(
      String admId) async {
    String fileName = "purchase$admId.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log(" getPurchasesSelectAll type : local");
      var jsonData = file.readAsStringSync();
      List<GetPurchasesSelectAll> purchasesSelectAll =
          getPurchasesSelectAllFromJson(jsonData);
      return purchasesSelectAll;
    } else {
      print(admId);
      var url = Uri.parse(baseUrl + "/users_purchasesSelectAll/$admId/0/100");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      print('Purchases Select All response Status: ${response.statusCode}');
      print('Purchases Select All response body: ${response.body}');
      if (response.statusCode == 201) {
        try {
          List<GetPurchasesSelectAll> purchasesSelectAll =
              getPurchasesSelectAllFromJson(response.body);
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
          return purchasesSelectAll;
        } catch (e) {
          return null;
        }
      } else
        return null;
    }
  }
  Future<List<ProductTags>> getProductCtg() async {
    String fileName = "productCtg.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      log(" Product Ctg type : local");
      var jsonData = file.readAsStringSync();
      List<ProductTags> getproducttags =
      productTagsFromJson(jsonData);
      return getproducttags;
    } else {
      log(" Product Ctg type : api");
      var url = Uri.parse(baseUrl + "/system_productsTags");
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
      });
      log('product Ctg List response status: ${response.statusCode}');
      log('Produc Ctg List response body: ${response.body}');
      if (response.statusCode == 201) {
        List<ProductTags> getproducttags =
        productTagsFromJson(response.body);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        log('Produc Ctg List response body: ${getproducttags}');
        return getproducttags;
      } else
        return null;
    }
  }

  Future<List<TncElement>> getTnC() async {
    var url = Uri.parse(baseUrl + "/admin_getTNC");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Basic ${gettoken()}',
    });
    print('getTnC response Status: ${response.statusCode}');
    print('getTnC  response body: ${response.body}');
    if (response.statusCode == 201) {
      try {
        Tnc tnc = tncFromJson(response.body);
        List<TncElement> list = tnc.tnc;
        return list;
      } catch (e) {
        return null;
      }
    } else
      return null;
  }
}
