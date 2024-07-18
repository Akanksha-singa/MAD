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

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No friends added yet'));
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return FriendCard(
              name: data['name'] ?? '',
              amount: data['amount'] ?? 0.0,
              imagePath: data['imagePath'] ?? 'assets/images/default_avatar.png',
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
  final dynamic amount;
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
    double parsedAmount = 0.0;
    if (amount is int) {
      parsedAmount = amount.toDouble();
    } else if (amount is double) {
      parsedAmount = amount;
    } else if (amount is String) {
      parsedAmount = double.tryParse(amount) ?? 0.0;
    }

    return GestureDetector(
      onDoubleTap: () => _showDeleteConfirmation(context),
      child: Container(
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
                    parsedAmount < 0 ? 'You owe' : 'Owes you',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '₹${parsedAmount.abs().toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this friend?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteFriend(context);
              },
            ),
          ],
        );
      },
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
