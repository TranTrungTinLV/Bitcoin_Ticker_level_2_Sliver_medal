import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class Price_Screen extends StatefulWidget {
  @override
  State<Price_Screen> createState() => _Price_ScreenState();
}

class _Price_ScreenState extends State<Price_Screen> {
  String? selectcurrently = 'AUD';

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropdowItems = [];
    for (String current in currentList) {
      print(current);
      var newItem = DropdownMenuItem(
        child: Text(current),
        value: current,
      );
      dropdowItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectcurrently,
        items: dropdowItems,
        onChanged: (value) {
          setState(() {
            selectcurrently = value;

            getData();
          });
        });
  }

  List<Text> getTickerBitcon() {
    List<Text> pickerTicket = [];

    for (String current in currentList) {
      Text(current);
      pickerTicket.add(Text(current));
    }
    return pickerTicket;
  }

  String bitcoinValueInUSD = '?';

  void getData() async {
    try {
      var data = await Coindata().getCoinData(selectcurrently);

      setState(() {
        bitcoinValueInUSD = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getDropDownButton();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('Bitcoin')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                child: Center(child: Text('1 BTC = $bitcoinValueInUSD USD')),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30),
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex) {
                print(selectedIndex);

                selectcurrently = currentList[selectedIndex];

                getData();
              },
              children: getTickerBitcon(),
            ),
            color: Colors.lightBlue,
          )
        ],
      ),
    );
  }
}


