import 'package:bitcoin_ticker/networking/rate_manager.dart';
import 'package:bitcoin_ticker/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/models/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  var currency = 'USD';
  var btcPrice = '? USD';
  var ethPrice = '? USD';
  var ltcPrice = '? USD';
  var rateManager = RateManager();

  List<DropdownMenuItem> getDropDownMenuItems() {
    List<DropdownMenuItem> currencies = [];
    for (var i = 0; i<currenciesList.length; i++) {
      currencies.add(
          DropdownMenuItem(
            child: Text(currenciesList[i]),
            value: currenciesList[i],
          )
      );
    }
    return currencies;
  }

  List<Text> getPickerItems() {
    List<Text> currencies = [];
    for (var i = 0; i<currenciesList.length; i++) {
      currencies.add(
          Text(currenciesList[i])
      );
    }
    return currencies;
  }

  DropdownButton androidDropDown() {
    return DropdownButton(
      value: this.currency,
      items: getDropDownMenuItems(),
      onChanged: (value) {
        this.currency = value;
        updateUI();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (value) {
          this.currency = currenciesList[value];
          updateUI();
        },
        children: getPickerItems()
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropDown();
    }
  }

  void updateUI() async {
    double btc    = await rateManager.getCryptocurrencyRate(this.currency, Bitcoin);
    double eth    = await rateManager.getCryptocurrencyRate(this.currency, Ethereum);
    double ltc    = await rateManager.getCryptocurrencyRate(this.currency, LiteCoin);
    this.btcPrice = "${btc.toInt().toString()} $currency";
    this.ethPrice = "${eth.toInt().toString()} $currency";
    this.ltcPrice = "${ltc.toInt().toString()} $currency";
    setState(() {});
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
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcPrice',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethPrice',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcPrice',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown()
          ),
        ],
      ),
    );
  }
}
