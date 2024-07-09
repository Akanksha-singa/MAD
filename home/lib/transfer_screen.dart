import 'package:flutter/material.dart';
import 'home_screen.dart'; // Ensure this file exists
import 'transfer_to_one_screen.dart'; // Ensure this file exists

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
              _buildContactItem(context, 'Ajay N M', '+91 7892817647', 'assets/images/img_profile_photo.png'),
              Divider(color: Colors.grey),
              _buildContactItem(context, 'Akanksha S', '+91 9036779915', 'assets/images/img_profile_photo_48x48.png'),
              Divider(color: Colors.grey),
              _buildContactItem(context, 'Aneesh KP', '+91 8277608384', 'assets/images/aneesh.png'),
              SizedBox(height: 24),
              Text(
                'All contacts',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              _buildContactItem(context, 'Ajay N M', '+91 7892817647', 'assets/images/img_profile_photo.png'),
              Divider(color: Colors.grey),
              _buildContactItem(context, 'Akanksha S', '+91 9036779915', 'assets/images/img_profile_photo_48x48.png'),
              Divider(color: Colors.grey),
              _buildContactItem(context, 'Aneesh KP', '+91 8277608384', 'assets/images/aneesh.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String name, String phone, String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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
                MaterialPageRoute(builder: (context) => TransferToOneScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}