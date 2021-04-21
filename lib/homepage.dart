import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {
   List currencies;
   final List<MaterialColor>_colors =[Colors.blueGrey,Colors.cyan,Colors.purple];





   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cryptocurrency Price App"),

      ),
      body: _cryptoWidget(),
      resizeToAvoidBottomPadding: false,

    );
  }

  Widget _cryptoWidget(){

    return new Container(
      child:new Column(
        children: <Widget>[
          new Flexible(
        child: new ListView.builder(
        itemCount:widget.currencies.length,
        itemBuilder: (BuildContext context,int index) {
      final Map currency =widget.currencies[index];
      final MaterialColor color =_colors[index %_colors.length];
      return _getListItemUi(currency,color);
    },
    ),
    )],

    ));

  }
  ListTile _getListItemUi(Map currency,MaterialColor color){
     return new ListTile(
       leading: new CircleAvatar(backgroundColor: color,
       child: new Text(currency['name'][0]),
       ),

       title: new Text(currency['name'],
       style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(
         currency['quote']['USD']['price'].toString(), currency['quote']['USD']['percent_change_1h'].toString()),
       isThreeLine: true,
     );

  }

  Widget _getSubtitleText(String price,String percentageChange){
     TextSpan priceTextWidget =new TextSpan(
         text: "\$$price\n",style: new TextStyle(color: Colors.black));
          String percentageChangeText ="1 Hour: $percentageChange%";
          TextSpan percentageChangeTextWidget;

          if(double.parse(percentageChange)>0){
            percentageChangeTextWidget=new TextSpan(text:percentageChangeText,
            style: new TextStyle(color:Colors.green));

          }
          else{
            percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
            style: new TextStyle(color: Colors.red));
          }
          return new RichText(
              text:new TextSpan(
                children: [priceTextWidget,percentageChangeTextWidget]));
  }
}
