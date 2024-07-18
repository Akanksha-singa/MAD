import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_settings_screen.dart';
import 'settings_screen.dart';
import 'transfer_screen.dart';
import 'splitwise_friends_tab_container_screen.dart';
import 'remainders_screen.dart';  // Import the RemainderScreen here
import 'dart:math' as math;

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
      _drawArc(canvas, center, radius, startAngle, sweepAngle, colors[i], strokeWidth);
      startAngle += sweepAngle;
    }
  }

  void _drawArc(Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle, Color color, double strokeWidth) {
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  double _walletBalance = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchWalletBalance();
  }

  Future<void> _fetchWalletBalance() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        setState(() {
          _walletBalance = documentSnapshot['wallet'].toDouble();
        });
      }
    } catch (e) {
      print("Error fetching wallet balance: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileSettingsScreen()),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.black),
          ),
        ),
        title: Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(context),
            _buildRecentTransfers(context),
            _buildExpensePieChart(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      color: Color(0xFFFF4D4D),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '₹${_walletBalance.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text('Wallet balance', style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(context, Icons.arrow_upward, 'Top up', null),
              _buildActionButton(context, Icons.arrow_downward, 'Withdraw', null),
              _buildActionButton(context, Icons.swap_horiz, 'Transfer', TransferScreen()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Widget? screen) {
    return GestureDetector(
      onTap: () {
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildRecentTransfers(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Transfers',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildTransferAvatar(context, '+', 'Add', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferScreen()),
                );
              }),
              _buildTransferAvatar(context, 'assets/images/ajayuu.png', 'Ajay N M'),
              _buildTransferAvatar(context, 'assets/images/akanksha.png', 'Akanksha S'),
              _buildTransferAvatar(context, 'assets/images/aneesh.png', 'Aneesh KP'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransferAvatar(BuildContext context, String imageAddress, String name, [VoidCallback? onTap]) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: imageAddress == '+' ? null : AssetImage(imageAddress),
              backgroundColor: imageAddress == '+' ? Colors.red[200] : null,
              child: imageAddress == '+' ? Text('+', style: TextStyle(color: Colors.white)) : null,
            ),
            SizedBox(height: 5),
            Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensePieChart() {
    return Column(
      children: [
        Container(
          height: 300,
          child: Center(
            child: SizedBox(
              height: 380.0,
              width: 380.0,
              child: Center(
                child: Container(
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
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
                                Colors.red[400]!,
                                Colors.red[200]!,
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: Size(110, 110),
                        painter: MyPieChartPainter(
                          percentages: [0.4, 0.1, 0.35, 0.15],
                          colors: [
                            Colors.blue,
                            Colors.red,
                            Colors.green,
                            Colors.yellow,
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          'Your\nExpenses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildExpensePercentages(),
      ],
    );
  }

  Widget _buildExpensePercentages() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPercentageCircle('Education', Colors.yellow, 0.15),
          _buildPercentageCircle('Entertainment', Colors.pink, 0.1),
          _buildPercentageCircle('Investments', Colors.green, 0.35),
          _buildPercentageCircle('Household Bills', Colors.purple, 0.4),
        ],
      ),
    );
  }

  Widget _buildPercentageCircle(String label, Color color, double percentage) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFF4D4D),
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 1) { // Split icon
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SplitwiseFriendsTabContainerScreen()),
          );
        } else if (index == 2) { // Reminders icon
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RemindersScreen()), // Navigate to RemainderScreen
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Split'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Reminders'),
      ],
    );
  }
}
