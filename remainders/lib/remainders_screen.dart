import 'package:flutter/material.dart';

class RemaindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remainders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'REX',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildRemainderCard('Monthly Rent', '13th June, 2024', 8000, Icons.home),
          SizedBox(height: 16),
          _buildRemainderCard('Amazon Subscription', '18th June, 2024', 999, Icons.movie),
          SizedBox(height: 16),
          _buildRemainderCard('Netflix Subscription', '11th June, 2024', 999, Icons.tv),
          SizedBox(height: 16),
          _buildRemainderCard('Electricity Bill', '9th June, 2024', 500, Icons.lightbulb_outline),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFF4D4D),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFF4D4D),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemainderCard(String title, String dueDate, int amount, IconData icon) {
    return Card(
      color: Color(0xFFE77676),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE70202),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Due date: $dueDate',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              '₹$amount',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}