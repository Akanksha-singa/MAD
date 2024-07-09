import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Confirm',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/img_illustration_4.svg',
                height: 200,
              ),
              SizedBox(height: 32),
              Text(
                'Transfer successful!',
                style: TextStyle(
                  color: Color(0xFFFF4D4D),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(text: 'You have successfully transferred\n'),
                    TextSpan(
                      text: '\$1,000',
                      style: TextStyle(
                        color: Color(0xFFFF4D4D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' to '),
                    TextSpan(
                      text: 'Ajay N M!',
                      style: TextStyle(
                        color: Color(0xFFE77676),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your back to wallet logic here
                    },
                    child: Text('Back to wallet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF4D4D),
                      textStyle: TextStyle(color: Colors.white),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}