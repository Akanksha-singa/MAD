import 'package:flutter/material.dart';

class SplitwiseFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildFriendItem('Ajay N M', -500, 'assets/images/ajay.png'),
        _buildFriendItem('Amelia K P', -500, 'assets/images/amelia.png'),
        _buildFriendItem('Angelina V', -500, 'assets/images/angelina.png'),
        _buildFriendItem('Irin', 50, 'assets/images/irin.png'),
      ],
    );
  }

  Widget _buildFriendItem(String name, double amount, String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE77676),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  amount < 0 ? 'You owe' : 'Owes you',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '₹${amount.abs()}',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}