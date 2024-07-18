import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemaindersScreen extends StatefulWidget {
  @override
  _RemaindersScreenState createState() => _RemaindersScreenState();
}

class _RemaindersScreenState extends State<RemaindersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFFFF4D4D)),
            ),
            SizedBox(width: 10),
            Text(
              'Remainders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _auth.currentUser != null
            ? _firestore.collection('remainders').doc(_auth.currentUser!.uid).collection('items').snapshots()
            : Stream.empty(),
        builder: (context, snapshot) {
          if (_auth.currentUser == null) {
            return Center(child: Text('Please log in to view remainders', style: TextStyle(color: Colors.white)));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final remainders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: remainders.length,
            itemBuilder: (context, index) {
              final remainder = remainders[index];
              return _buildRemainderCard(
                remainder.id,
                remainder['title'],
                remainder['dueDate'],
                remainder['amount'],
                remainder['icon'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new remainder
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFF4D4D),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFF4D4D),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
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
      ),
    );
  }

  Widget _buildRemainderCard(String id, String title, String dueDate, int amount, String iconName) {
    return Dismissible(
      key: Key(id),
      background: Container(
        color: Colors.green,
        child: Icon(Icons.check, color: Colors.white),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // Delete the remainder
          _firestore.collection('remainders').doc(_auth.currentUser!.uid).collection('items').doc(id).delete();
        } else {
          // Mark as done
          _firestore.collection('remainders').doc(_auth.currentUser!.uid).collection('items').doc(id).update({'isDone': true});
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFFF4D4D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(IconData(int.parse(iconName), fontFamily: 'MaterialIcons'), color: Color(0xFFFF4D4D)),
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
      ),
    );
  }
}