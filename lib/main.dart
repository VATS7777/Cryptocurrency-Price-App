import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cryptocurrency_app/loading.dart';
import 'package:http/http.dart' as http;
import 'package:cryptocurrency_app/homepage.dart';

void main() async{
//  Future<List> _futureOfList = _getList();
////  List list = await _futureOfList ;

  Future<List> _futureOfList = getCurrencies();
  List currencies = await _futureOfList;

//  List currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;

 MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme:new ThemeData(primarySwatch: Colors.blue),
      home:new HomePage(_currencies),
    );
  }

}

// ignore: missing_return
Future<List>  getCurrencies() async{



  String cryptoUrl ="https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  http.Response response =await http.get(cryptoUrl,headers: {
    'X-CMC_PRO_API_KEY': 'fefa024a-fbfd-4f51-b06e-b6b510a985fe',
    "Accept": "application/json",

  });
  if (response.statusCode == 200) {
//    return json.decode(response.body);
//    return Future.value([1,2,3,4]);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
//    print(data[0]["name"]);

  return Future.value(data);
  }

}

