import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hopepoints/Model/ProductlistAll.dart';
import 'package:hopepoints/Model/productDetails.dart';
import 'package:hopepoints/Screens/ProductPage.dart';
import 'package:hopepoints/Screens/home.dart';
import 'package:hopepoints/Screens/offersPage.dart';
import 'package:hopepoints/Screens/walletPage.dart';
import 'package:hopepoints/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget {
  int index;
  Navbar({this.index});
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  ApiService apiService;
  List<GetProductListAll> products = [];
  String token = '';
  String uuid = '';
  void gettokenAndUuid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokentemp = preferences.getString('token');
    String uuidtemp = preferences.getString('uuid');
    String login = preferences.getString('logged');
    print(login);
    setState(() {
      token = tokentemp;
      uuid = uuidtemp;
    });
  }

  getProducts() {
    gettokenAndUuid();
    apiService = new ApiService(token: token);
    apiService.productlistall().then((value) {
      if (value != null) {
        setState(() {
          products = value;
        });
      } else {
        log("null value");
      }
    });
  }

  @override
  void initState() {
    ApiService apiService = new ApiService();
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      return Home();
    }
    if (widget.index == 1) {
      return ProductMain();
    }
    if (widget.index == 2) {
      return Offers();
    }
    if (widget.index == 3) {
      return WalletPage();
    } else {
      return Container();
    }
  }
}
