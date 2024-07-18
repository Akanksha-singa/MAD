import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_fail_screen.dart';
import 'payment_success_screen.dart';
import 'transfer_screen.dart';

class TransferToOneScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String imagePath;

  TransferToOneScreen({required this.name, required this.phone, required this.imagePath});

  @override
  _TransferToOneScreenState createState() => _TransferToOneScreenState();
}

class _TransferToOneScreenState extends State<TransferToOneScreen> {
  String amount = '00.00';
  String userPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    fetchLatestUserPhoneNumber();
  }

  Future<void> fetchLatestUserPhoneNumber() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userPhoneNumber = querySnapshot.docs.first.id;
        });
      } else {
        print('No users found in the database.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void updateAmount(String value) {
    setState(() {
      if (amount == '00.00') {
        amount = value;
      } else {
        amount += value;
      }
    });
  }

  Future<void> processPayment() async {
    double amountValue = double.tryParse(amount) ?? 0.0;
    if (amountValue > 0) {
      bool success = await updateWalletBalance(amountValue);
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
              amount: amount,
              recipientName: widget.name,
            ),
          ),
        ).then((_) => navigateBackToTransferScreen());
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentFailScreen(),
          ),
        ).then((_) => navigateBackToTransferScreen());
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentFailScreen(),
        ),
      ).then((_) => navigateBackToTransferScreen());
    }
  }

  Future<bool> updateWalletBalance(double amountToDeduct) async {
    try {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userPhoneNumber);

      return FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userDoc);

        if (!snapshot.exists) {
          throw Exception("User does not exist!");
        }

        double currentBalance = (snapshot.get('wallet') as num).toDouble();
        if (currentBalance < amountToDeduct) {
          throw Exception("Insufficient funds");
        }

        double newBalance = currentBalance - amountToDeduct;
        transaction.update(userDoc, {'wallet': newBalance});

        return true;
      });
    } catch (e) {
      print('Error updating wallet balance: $e');
      return false;
    }
  }

  void navigateBackToTransferScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TransferScreen()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
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
            backgroundImage: AssetImage(widget.imagePath),
          ),
          SizedBox(height: 10),
          Text(
            widget.name,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            widget.phone,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 40),
          Text(
            'Enter Amount',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 10),
          Text(
            '₹$amount',
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
                  onPressed: processPayment,
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
