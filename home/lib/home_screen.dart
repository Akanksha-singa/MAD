// home_screen.dart
import 'package:flutter/material.dart';
import 'profile_settings_screen.dart';

class HomeScreen extends StatelessWidget {
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
              MaterialPageRoute(builder: (context) => ProfileSettingsscreen()),
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            _buildRecentTransfers(),
            _buildExpensePieChart(),
            _buildExpenseCategories(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      color: Color(0xFFFF4D4D),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '₹14,235.34',
            style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text('Main balance', style: TextStyle(color: Colors.white)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.arrow_upward, 'Top up'),
              _buildActionButton(Icons.arrow_downward, 'Withdraw'),
              _buildActionButton(Icons.swap_horiz, 'Transfer'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildRecentTransfers() {
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
              _buildTransferAvatar('+', 'Add'),
              _buildTransferAvatar('A', 'Ajay N M'),
              _buildTransferAvatar('A', 'Akanksha S'),
              _buildTransferAvatar('A', 'Aneesh KP'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransferAvatar(String label, String name) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: label == '+' ? Colors.red[200] : Colors.orange,
            child: Text(label, style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildExpensePieChart() {
    // Implement pie chart here
    return Container(
      height: 200,
      color: Colors.grey[900],
      child: Center(
        child: Text('Expense Pie Chart', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildExpenseCategories() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildExpenseCategory('Education', Colors.yellow),
          _buildExpenseCategory('Entertainment', Colors.pink),
          _buildExpenseCategory('Investments', Colors.green),
          _buildExpenseCategory('Household Bills', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildExpenseCategory(String category, Color color) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 5),
        Text(
          category,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFF4D4D),
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Split'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Bills'),
      ],
    );
  }
}
