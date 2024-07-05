import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyPieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 10.0;
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Red line (40%)
    _drawArc(canvas, center, radius, math.pi * 2 * 0.4, Colors.blue, strokeWidth);

    // Blue line (10%)
    _drawArc(canvas, center, radius, math.pi * 2 * 0.1, Colors.red, strokeWidth);

    // Green line (35%)
    _drawArc(canvas, center, radius, math.pi * 2 * 0.35, Colors.green, strokeWidth);

    // Yellow line (15%)
    _drawArc(canvas, center, radius, math.pi * 2 * 0.15, Colors.yellow, strokeWidth);
  }

  void _drawArc(Canvas canvas, Offset center, double radius, double sweepAngle, Color color, double strokeWidth) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start angle (top)
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red[400]!, // Add ! to assert non-nullability
                  Colors.red[200]!, // Add ! to assert non-nullability
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'REX',
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  '₹14,235.34',
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Main balance',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.white),
                        Text('Topup', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.arrow_downward, color: Colors.white),
                        Text('Withdraw', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.swap_horiz, color: Colors.white),
                        Text('Transfer', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 0.0),
                  Text(
                    'Recent Transfers',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      _buildCircleAvatarWithText(Icons.add, 'Add'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset('assets/images/ajay.png', 'Ajay'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset('assets/images/akanksha.png', 'Akanksha'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset('assets/images/aneesh.png', 'Aneesh'),
                    ],
                  ),

                  SizedBox(height: 1.0),
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Circle with gradient background
                            Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red[400]!, // Red gradient start color
                                      Colors.red[200]!, // Red gradient end color
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Lines representing percentages
                            CustomPaint(
                              size: Size(150, 150),
                              painter: MyPieChartPainter(),
                            ),
                            // Centered text
                            Center(
                              child: Text(
                                'Your\nExpenses',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildExpenseCategory('Education', Colors.blue),
                      _buildExpenseCategory('Entertainment', Colors.red),
                      _buildExpenseCategory('Investments', Colors.yellow),
                      _buildExpenseCategory('Household Bills', Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Expenses',
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAvatarWithText(IconData iconData, String text) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(iconData),
          backgroundColor: Colors.red[200]!, // Add ! to assert non-nullability
        ),
        SizedBox(height: 5.0),
        Text(
          text,
          style: TextStyle(fontSize: 10.0),
        ),
      ],
    );
  }

  Widget _buildCircleAvatarWithTextFromAsset(String assetPath, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(assetPath),
        ),
        SizedBox(height: 5.0),
        Text(
          text,
          style: TextStyle(fontSize: 10.0),
        ),
      ],
    );
  }

  Widget _buildExpenseCategory(String category, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
        SizedBox(height: 5.0),
        Text(
          category,
          style: TextStyle(fontSize: 10.0, color: color),
        ),
      ],
    );
  }
}