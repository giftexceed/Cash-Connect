import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../services/api_services/shared_services.dart';
import '../utilities/config.dart';

class AccountProvider with ChangeNotifier {
  int accountBalance = 0;
  static var client = http.Client();

  getBalance() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}'
    };

    var accountBalanceURL =
        "${Config.accountBalanceAPI}/${loginDetails.data.phoneNumber}";

    var url = Uri.http(Config.apiURL, accountBalanceURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      this.accountBalance = data;

      notifyListeners();

      // return usersFromJson(data["balance"]);
    } else {
      return null;
    }
  }
}
