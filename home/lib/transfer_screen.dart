import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'transfer_to_one_screen.dart';

class TransferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
        title: Text(
          'Back',
          style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transfer to',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFE77676),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'New contact',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.white)),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search contact',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Frequent contacts',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              ContactList(frequent: true),
              SizedBox(height: 24),
              Text(
                'All contacts',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              ContactList(frequent: false),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  final bool frequent;

  ContactList({required this.frequent});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('contacts')
          .where('frequent', isEqualTo: frequent)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return ContactCard(
              name: data['name'],
              phone: data['phone'],
              imagePath: data['imagePath'],
            );
          }).toList(),
        );
      },
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String phone;
  final String imagePath;

  ContactCard({required this.name, required this.phone, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(color: Colors.white)),
                  Text(phone, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TransferToOneScreen(name: name, phone: phone, imagePath: imagePath)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}