import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyPieChartPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;

  MyPieChartPainter({required this.percentages, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 15.0;
    final double radius = (size.width + 32) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    double startAngle = -math.pi / 2;

    for (int i = 0; i < percentages.length; i++) {
      final double sweepAngle = math.pi * 2 * percentages[i];
      _drawArc(canvas, center, radius, startAngle, sweepAngle, colors[i],
          strokeWidth);
      startAngle += sweepAngle;
    }
  }

  void _drawArc(Canvas canvas, Offset center, double radius, double startAngle,
      double sweepAngle, Color color, double strokeWidth) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Lexend', // Set the default font family to Lexend
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'ADITYA',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // Define onPressed functionality here
                        },
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
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
                          Text('Withdraw',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.swap_horiz, color: Colors.white),
                          Text('Transfer',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Transfers',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Changed to black for visibility
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      _buildCircleAvatarWithText(Icons.add, 'Add'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset(
                          'assets/images/ajay.png', 'Ajay'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset(
                          'assets/images/akanksha.png', 'Akanksha'),
                      SizedBox(width: 10.0),
                      _buildCircleAvatarWithTextFromAsset(
                          'assets/images/aneesh.png', 'Aneesh'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: SizedBox(
                      height: 200.0, // Adjust height as needed
                      width: 200.0, // Adjust width as needed
                      child: Center(
                        child: Container(
                          height: 150,
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
                                        Colors.red[
                                        400]!, // Red gradient start color
                                        Colors.red[
                                        200]!, // Red gradient end color
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Lines representing percentages
                              CustomPaint(
                                size: Size(110, 110),
                                painter: MyPieChartPainter(
                                  percentages: [
                                    0.4,
                                    0.1,
                                    0.35,
                                    0.15
                                  ], // Add your percentages here
                                  colors: [
                                    Colors.blue,
                                    Colors.red,
                                    Colors.green,
                                    Colors.yellow
                                  ], // Add your colors here
                                ),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFF4D4D), // Set background color to #FF4D4D
        iconSize: 14,
        selectedItemColor: Colors.yellow, // Set selected item color to yellow
        unselectedItemColor: Colors.white, // Set unselected item color to white
        selectedLabelStyle: TextStyle(
            color: Colors.yellow), // Set selected label text color to yellow
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split_outlined),
            label: 'SplitWise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_sharp),
            label: 'Bill Reminders',
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
          style: TextStyle(fontSize: 10.0, color: Colors.white),
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
          style: TextStyle(
              fontSize: 10.0, color: Colors.white), // Set text color to white
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
        SizedBox(height: 7.0),
        Text(
          category,
          style: TextStyle(
            fontSize: 13.0,
            color: color,
            fontFamily: 'Lexend', // Set the font family to Lexend
          ),
        ),
      ],
    );
  }
}