import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splitwise_friends_page.dart';
import 'splitwise_groups_page.dart';

class SplitwiseGroupsTabContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Split Wise'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'FRIENDS'),
              Tab(text: 'GROUPS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SplitwiseFriendsPage(),
            SplitwiseGroupsPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showAddDialog(context),
        ),
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
                  _showAddGroupDialog(context);
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

  void _showAddGroupDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    final splitByController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Group'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Group Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Total Amount'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: splitByController,
                  decoration: InputDecoration(labelText: 'Split By (number of people)'),
                  keyboardType: TextInputType.number,
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
                _addGroup(
                  context,
                  nameController.text,
                  descriptionController.text,
                  amountController.text,
                  splitByController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
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
      'imagePath': 'assets/images/default_avatar.png',
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Friend added successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add friend: $error')));
    });
  }

  void _addGroup(BuildContext context, String name, String description, String amount, String splitBy) {
    if (name.isEmpty || amount.isEmpty || splitBy.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all required fields')));
      return;
    }

    double totalAmount = double.tryParse(amount) ?? 0.0;
    int numberOfPeople = int.tryParse(splitBy) ?? 1;
    double amountPerPerson = totalAmount / numberOfPeople;

    FirebaseFirestore.instance.collection('SplitWiseGroups').add({
      'name': name,
      'description': description,
      'totalAmount': totalAmount,
      'memberCount': numberOfPeople,
      'amountPerPerson': amountPerPerson,
      'imagePath': 'assets/images/default_group.png',
      'createdAt': FieldValue.serverTimestamp(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group added successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add group: $error')));
    });
  }
}