import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplitwiseFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('SplitWise').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return FriendCard(
              name: data['name'],
              amount: data['amount'].toDouble(),
              imagePath: data['imagePath'],
              phoneNumber: doc.id,
            );
          }).toList(),
        );
      },
    );
  }
}

class FriendCard extends StatelessWidget {
  final String name;
  final double amount;
  final String imagePath;
  final String phoneNumber;

  FriendCard({
    required this.name,
    required this.amount,
    required this.imagePath,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () => _deleteFriend(context),
          ),
        ],
      ),
    );
  }

  void _deleteFriend(BuildContext context) {
    FirebaseFirestore.instance.collection('SplitWise').doc(phoneNumber).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Friend removed')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove friend: $error')));
    });
  }
}