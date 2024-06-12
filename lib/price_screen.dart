import 'package:coin_checker/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

const String coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
double _rate = 0.0;
String _selectedItem = 'AUD';

Future<dynamic> getCoinData() async {
  String virtualCurrency = 'BTC';

  final String url = '$coinApiUrl/$virtualCurrency/$_selectedItem';

  NetworkHelper networkHelper = NetworkHelper(url: url);
  var coinData = await networkHelper.getData();
  return coinData;
}

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownLists = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownLists.add(newItem);
    }

    return DropdownButton<String>(
      value: _selectedItem,
      items: dropdownLists,
      onChanged: (String? value) {
        setState(
          () {
            _selectedItem = value!;
            updateRate();
          },
        );
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencyText = [];
    for (String listNum in currenciesList) {
      Widget listNumText = Text(listNum);
      currencyText.add(listNumText);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedindex) {
        setState(() {
          _selectedItem = currenciesList[selectedindex];
          updateRate();
        });
      },
      children: currencyText,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateRate();
  }

  void updateRate() async {
    try {
      var coinData = await getCoinData();
      setState(() {
        _rate = coinData['rate'];
      });
    } catch (e) {
      print('e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${_rate.toInt()} USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}
