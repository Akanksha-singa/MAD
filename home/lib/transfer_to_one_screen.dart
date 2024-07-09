import 'package:flutter/material.dart';

class TransferToOneScreen extends StatefulWidget {
  @override
  _TransferToOneScreenState createState() => _TransferToOneScreenState();
}

class _TransferToOneScreenState extends State<TransferToOneScreen> {
  String amount = '00.00';

  void updateAmount(String value) {
    setState(() {
      if (amount == '00.00') {
        amount = value;
      } else {
        amount += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Back',
          style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Transfer to',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage('assets/images/img_profile_photo.png'),
          ),
          SizedBox(height: 10),
          Text(
            'Ajay N M',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            '+91 7892817647',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 40),
          Text(
            'Enter Amount',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 10),
          Text(
            '₹\amount',
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),
          Container(
            height: 2,
            width: 200,
            color: Color(0xFFFF4D4D),
          ),
          Spacer(),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                buildNumberRow(['1', '2', '3']),
                buildNumberRow(['4', '5', '6']),
                buildNumberRow(['7', '8', '9']),
                buildNumberRow(['.', '0', 'X']),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4D4D),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumberRow(List<String> numbers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: numbers.map((number) {
          return TextButton(
            child: Text(
              number,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            onPressed: () {
              if (number != 'X') {
                updateAmount(number);
              } else {
                setState(() {
                  if (amount.length > 1) {
                    amount = amount.substring(0, amount.length - 1);
                  } else {
                    amount = '00.00';
                  }
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}