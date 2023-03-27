import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import '../services/pricing.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String currencyChanger = 'AUD';
  String price = '?';

  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async{
    try {
      var priceOfBTC = await PriceOfBTC().getBTCCurrentPrice(currencyChanger);
      setState(() {
        price = priceOfBTC.toStringAsFixed(0);
      });
    }
    catch(e) {
      print(e);
    }
  }


  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for(String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String> (
      value: currencyChanger,
      onChanged: (value) {
        setState(() {
          currencyChanger = value as String;
          getData();
        });
      },
      items: dropdownItems,
    );
  }

  // ignore: non_constant_identifier_names
  CupertinoPicker IOSPicker() {
    List<Text> pickerItems = [];
    for(String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (index) {
      },
      itemExtent: 30.0,
      children: pickerItems,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(currencyChanger: currencyChanger, price: price, selectedCurrency: cryptoList[0],),
          CryptoCard(currencyChanger: currencyChanger, price: price, selectedCurrency: cryptoList[1],),
          CryptoCard(currencyChanger: currencyChanger, price: price, selectedCurrency: cryptoList[2],),
          const SizedBox(
            height: 216.4,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.currencyChanger,
    required this.price,
    required this.selectedCurrency
  });

  final selectedCurrency;
  final String price;
  final String currencyChanger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCurrency = $price $currencyChanger',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
