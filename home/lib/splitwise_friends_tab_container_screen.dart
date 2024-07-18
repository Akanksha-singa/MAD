import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splitwise_friends_page.dart';
import 'splitwise_groups_page.dart';

class SplitwiseFriendsTabContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Split Wise'),
          actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .limit(1)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No data available');
                }

                // Safely convert the wallet balance to double
                double walletBalance = 0.0;
                var walletData = (snapshot.data!.docs.first.data() as Map<String, dynamic>)['wallet'];
                if (walletData is int) {
                  walletBalance = walletData.toDouble();
                } else if (walletData is double) {
                  walletBalance = walletData;
                } else if (walletData is String) {
                  walletBalance = double.tryParse(walletData) ?? 0.0;
                }

                return _buildHeading(); // Replacing the balance card with a heading
              },
            ),
            TabBar(
              tabs: [Tab(text: 'FRIENDS'), Tab(text: 'GROUPS')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SplitwiseFriendsPage(),
                  SplitwiseGroupsPage(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showAddDialog(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Splitwise',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text('Add Friend'),
                onPressed: () {
                  Navigator.pop(context);
                  _showAddFriendDialog(context);
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                child: Text('Add Group'),
                onPressed: () {
                  Navigator.pop(context);
                  // Implement add group logic here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final amountController = TextEditingController();
    bool youOwe = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Friend'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                    ),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    Row(
                      children: [
                        Text('You owe'),
                        Switch(
                          value: youOwe,
                          onChanged: (value) {
                            setState(() {
                              youOwe = value;
                            });
                          },
                        ),
                        Text('Owes you'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    _addFriend(
                      context,
                      nameController.text,
                      phoneController.text,
                      amountController.text,
                      youOwe,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addFriend(BuildContext context, String name, String phone, String amount, bool youOwe) {
    if (name.isEmpty || phone.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    double parsedAmount = double.tryParse(amount) ?? 0.0;
    if (youOwe) {
      parsedAmount = -parsedAmount;
    }

    FirebaseFirestore.instance.collection('SplitWise').doc(phone).set({
      'name': name,
      'amount': parsedAmount,
      'imagePath': 'assets/images/default_avatar.png', // Use a default image path
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Friend added successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add friend: $error')));
    });
  }
}
