import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplitwiseGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('SplitWiseGroups').snapshots(),
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
            return GroupCard(
              name: data['name'] ?? 'Unnamed Group',
              totalAmount: (data['totalAmount'] ?? 0).toDouble(),
              imagePath: data['imagePath'] ?? 'assets/images/default_group.png',
              groupId: doc.id,
              memberCount: data['memberCount'] ?? 0,
              amountPerPerson: (data['amountPerPerson'] ?? 0).toDouble(),
            );
          }).toList(),
        );
      },
    );
  }
}

class GroupCard extends StatelessWidget {
  final String name;
  final double totalAmount;
  final String imagePath;
  final String groupId;
  final int memberCount;
  final double amountPerPerson;

  GroupCard({
    required this.name,
    required this.totalAmount,
    required this.imagePath,
    required this.groupId,
    required this.memberCount,
    required this.amountPerPerson,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => _showDeleteConfirmation(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF76A5E7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Members: $memberCount',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () => _showDeleteConfirmation(context),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              'Amount per person: ₹${amountPerPerson.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 14),
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
          content: Text('Are you sure you want to delete this group?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteGroup(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteGroup(BuildContext context) {
    FirebaseFirestore.instance.collection('SplitWiseGroups').doc(groupId).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group removed')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove group: $error')));
    });
  }
}